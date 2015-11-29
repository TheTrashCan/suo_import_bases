-- в базе suo_history

-- INSERT INTO office_ip_id (office_id, dictionary_id, region, name, service_start_id, service_end_id, resource_start_id, resource_end_id, slot_start_id, slot_end_id)
-- VALUES (
--     1 + (SELECT *
--          FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from offices')
--              AS t1(id int)),
--
--     (SELECT *
--        FROM dblink('dbname=foo1', 'select dictionary_id from offices limit 1')),
--
--     (SELECT *
--        FROM dblink('dbname=foo1', 'select region from offices limit 1')),
--
--     (SELECT *
--       FROM dblink('dbname=foo1', 'select name from offices limit 1'))
--
--     1 + (select case when max(id) is null then 0 else max(id) end from services_history),
--
--     (select case when max(id) is null then 0 else max(id) end from services_history) + (SELECT *
--                                                                                 FROM dblink('dbname=foo1', 'select case when max(id) is null then 0 else max(id) end from services')
--                                                                                     AS t1(id int)),
--
--     1 + (select case when max(id) is null then 0 else max(id) end from resources_history),
--
--     (select case when max(id) is null then 0 else max(id) end from resources_history) + (SELECT *
--                                                                                  FROM dblink('dbname=foo1', 'select case when max(id) is null then 0 else max(id) end from resources')
--                                                                                      AS t1(id int)),
--
--     1 + (select case when max(id) is null then 0 else max(id) end from slots_history),
--
--     (select case when max(id) is null then 0 else max(id) end from slots_history) + (SELECT *
--                                                                              FROM dblink('dbname=foo1', 'select case when max(id) is null then 0 else max(id) end from slots')
--                                                                                  AS t1(id int))
-- );

UPDATE office_ip_id SET
  office_id = 1 + (SELECT *
                   FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from offices')
                     AS t1(id int)),
  dictionary_id = (SELECT *
                   FROM dblink('dbname=foo1', 'select dictionary_id from offices limit 1') AS t2(dictionary_id int)),
  region = (SELECT *
            FROM dblink('dbname=foo1', 'select region from offices limit 1') AS t3(region text)),
  name = (SELECT *
          FROM dblink('dbname=foo1', 'select name from offices limit 1') AS t4(name text)),
  service_start_id =  1 + (select case when max(id) is null then 0 else max(id) end from services_history),
  service_end_id = (select case when max(id) is null then 0 else max(id) end from services_history) + (SELECT *
                                                                                                       FROM dblink('dbname=foo1', 'select case when max(id) is null then 0 else max(id) end from services')
                                                                                                         AS t5(id int)),
  resource_start_id = 1 + (select case when max(id) is null then 0 else max(id) end from resources_history),
  resource_end_id = (select case when max(id) is null then 0 else max(id) end from resources_history) + (SELECT *
                                                                                                         FROM dblink('dbname=foo1', 'select case when max(id) is null then 0 else max(id) end from resources')
                                                                                                           AS t6(id int)),
  slot_start_id = 1 + (select case when max(id) is null then 0 else max(id) end from slots_history),
  slot_end_id = (select case when max(id) is null then 0 else max(id) end from slots_history) + (SELECT *
                                                                                                 FROM dblink('dbname=foo1', 'select case when max(id) is null then 0 else max(id) end from slots')
                                                                                                   AS t7(id int))
WHERE id = (SELECT MAX(id) FROM office_ip_id);


SELECT 'копируем resources в историю' AS info;

INSERT INTO resources_history (name, service_id, position, can_one_day_previous, service_time, after_service_time, can_record, how_get, payment, term, recipients, reason, result, documents_push, documents_pull, information, control, procedure, organizations, acts, avg_time_fiz, avg_time_jur, norm_deviation, bad_deviation, ul_service_time)
  (
    SELECT name, service_id, position, can_one_day_previous, service_time, after_service_time, can_record, how_get, payment, term, recipients, reason, result, documents_push, documents_pull, information, control, procedure, organizations, acts, avg_time_fiz, avg_time_jur, norm_deviation, bad_deviation, ul_service_time
    FROM dblink('dbname=foo1', 'SELECT name, service_id, position, can_one_day_previous, service_time, after_service_time, can_record, how_get, payment, term, recipients, reason, result, documents_push, documents_pull, information, control, procedure, organizations, acts, avg_time_fiz, avg_time_jur, norm_deviation, bad_deviation, ul_service_time FROM resources ORDER BY id') AS
         t1(
         name                  character varying,
         service_id            integer,
         position              integer,
         can_one_day_previous  boolean,
         service_time          integer,
         after_service_time    integer,
         can_record            boolean,
         how_get               text,
         payment               text,
         term                  text,
         recipients            text,
         reason                text,
         result                text,
         documents_push        text,
         documents_pull        text,
         information           text,
         control               text,
         procedure             text,
         organizations         text,
         acts                  text,
         avg_time_fiz          integer,
         avg_time_jur          integer,
         norm_deviation        integer,
         bad_deviation         integer,
         ul_service_time       integer
         )
  );

SELECT 'копируем services в историю' AS info;

INSERT INTO services_history (code, name, visible, status, letter_code, short_name, service_time, parent_id)
  (
    SELECT code, name, visible, status, letter_code, short_name, service_time, parent_id
    FROM dblink('dbname=foo1', 'SELECT code, name, visible, status, letter_code, short_name, service_time, parent_id FROM services ORDER BY id') AS
         t1(
         code          character varying(255),
         name          text,
         visible       boolean,
         status        character varying(255),
         letter_code   character varying(255),
         short_name    text,
         service_time  integer,
         parent_id     integer
         )
  );

SELECT 'копируем slots в историю' AS info;

INSERT INTO slots_history (resource_id, number, status, created_at, updated_at, user_id, window_number, service_date, pin, start_time, end_time, mark, last_name, first_name, middle_name, denial_reason, actual_time_call, counter_id, exact_time, print_flag, initial_service_date, passport_number, passport_series, objects_count, organization_name, ogrn, inn, kpp, office_id, recording_method, book_id, activate_pin_date, service_time, uuid, rank)
  (
    SELECT resource_id, number, status, created_at, updated_at, user_id, window_number, service_date, pin, start_time, end_time, mark, last_name, first_name, middle_name, denial_reason, actual_time_call, counter_id, exact_time, print_flag, initial_service_date, passport_number, passport_series, objects_count, organization_name, ogrn, inn, kpp, office_id, recording_method, book_id, activate_pin_date, service_time, uuid, rank
    FROM dblink('dbname=foo1', 'SELECT resource_id, number, status, created_at, updated_at, user_id, window_number, service_date, pin, start_time, end_time, mark, last_name, first_name, middle_name, denial_reason, actual_time_call, counter_id, exact_time, print_flag, initial_service_date, passport_number, passport_series, objects_count, organization_name, ogrn, inn, kpp, office_id, recording_method, book_id, activate_pin_date, service_time, uuid, rank FROM slots ORDER BY id') AS
         t1(
         resource_id           integer,
         number                character varying(255),
         status                character varying(255),
         created_at            timestamp without time zone,
         updated_at            timestamp without time zone,
         user_id               integer,
         window_number         character varying(255),
         service_date          timestamp without time zone,
         pin                   character varying(255),
         start_time            timestamp without time zone,
         end_time              timestamp without time zone,
         mark                  character varying(255),
         last_name             character varying(255),
         first_name            character varying(255),
         middle_name           character varying(255),
         denial_reason         text,
         actual_time_call      timestamp without time zone,
         counter_id            integer,
         exact_time            boolean,
         print_flag            integer,
         initial_service_date  timestamp without time zone,
         passport_number       character varying(255),
         passport_series       character varying(255),
         objects_count         integer,
         organization_name     character varying(255),
         ogrn                  bigint,
         inn                   bigint,
         kpp                   integer,
         office_id             integer,
         recording_method      character varying(255),
         book_id               character varying(255),
         activate_pin_date     timestamp without time zone,
         service_time          integer,
         uuid                  character varying(255),
         rank                  double precision
         )
  );