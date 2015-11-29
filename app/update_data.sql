-- 'удаление ненужных таблиц'
SELECT 'удаление ненужных таблиц' AS info;

DROP TABLE users_id_seq;
DROP TABLE unloading_events_id_seq;
DROP TABLE system_settings_id_seq;
DROP TABLE soms_settings_id_seq;
DROP TABLE settings_id_seq;
DROP TABLE service_normatives_id_seq;
DROP TABLE report_parameters_id_seq;
DROP TABLE register_action_normatives_id_seq;
DROP TABLE portal_tickets_id_seq;
DROP TABLE offices_id_seq;
DROP TABLE office_settings_id_seq;
DROP TABLE office_checks_id_seq;
DROP TABLE feedback_question_answers_id_seq;
DROP TABLE feedback_forms_id_seq;
DROP TABLE eq_tickets_id_seq;
DROP TABLE documents_id_seq;
DROP TABLE dictionaries_id_seq;
DROP TABLE counters_id_seq;
DROP TABLE conversation_fs_id_seq;
DROP TABLE client_infos_id_seq;
DROP TABLE classifiers_id_seq;
DROP TABLE classifier_versions_id_seq;
DROP TABLE changes_id_seq;
DROP TABLE board_settings_id_seq;
DROP TABLE activities_id_seq;

ALTER TABLE offices DROP COLUMN asvz_office_id;
ALTER TABLE offices DROP COLUMN code;
ALTER TABLE offices DROP COLUMN use_central_playlist;
ALTER TABLE board_settings DROP COLUMN hide_slot_and_window_number;
ALTER TABLE office_settings DROP COLUMN hide_fio_in_prerecord_mode;
ALTER TABLE office_settings DROP COLUMN hide_fio_in_live_mode;
ALTER TABLE office_settings DROP COLUMN hide_passport_in_prerecord_mode;
ALTER TABLE office_settings DROP COLUMN hide_passport_in_live_mode;
ALTER TABLE office_settings DROP COLUMN terminal_inactivity_timeout;
ALTER TABLE office_settings DROP COLUMN max_appointments_for_user;
ALTER TABLE office_settings DROP COLUMN max_objects_count;
ALTER TABLE office_settings DROP COLUMN hide_objects_count_in_talon;
ALTER TABLE office_settings DROP COLUMN hide_object_type_in_prerecord_mode;
ALTER TABLE office_settings DROP COLUMN hide_object_type_in_live_mode;

SELECT 'таблица additional_service_times больше не нужна' AS info;
DROP TABLE additional_service_times;

SELECT 'таблица applicant_types больше не нужна' AS info;
DROP TABLE applicant_types;

--SELECT 'таблица creeping_line_patterns больше не нужна' AS info;
--DROP TABLE creeping_line_patterns;

SELECT 'таблица feedback_questions больше не нужна' AS info;
DROP TABLE feedback_questions;

SELECT 'таблица instance_types больше не нужна' AS info;
DROP TABLE instance_types;

SELECT 'таблица mortgage_types больше не нужна' AS info;
DROP TABLE mortgage_types;

--SELECT 'таблица offices_resources больше не нужна' AS info;
--DROP TABLE offices_resources;

SELECT 'таблица register_actions больше не нужна' AS info;
DROP TABLE register_actions;

SELECT 'таблица reports больше не нужна' AS info;
DROP TABLE reports;

SELECT 'таблица resources больше не нужна' AS info;
DROP TABLE resources;

SELECT 'таблица schema_migrations больше не нужна' AS info;
DROP TABLE schema_migrations;

SELECT 'таблица security_images больше не нужна' AS info;
DROP TABLE security_images;

SELECT 'таблица service_frgus больше не нужна' AS info;
DROP TABLE service_frgus;

SELECT 'таблица services больше не нужна' AS info;
DROP TABLE services;

SELECT 'таблица sources больше не нужна' AS info;
DROP TABLE sources;

SELECT 'таблица supplying_methods больше не нужна' AS info;
DROP TABLE supplying_methods;

-- обновляем все id, которые связаны с офисами 

SELECT 'обновляем все id, которые связаны с офисами' AS info;

UPDATE offices SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from offices')
      AS t1(id int));

UPDATE slots SET office_id = office_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from offices')
      AS t1(id int));

UPDATE users SET office_id = office_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from offices')
      AS t1(id int));

UPDATE board_settings SET office_id = office_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from offices')
      AS t1(id int));

UPDATE office_settings SET office_id = office_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from offices')
      AS t1(id int));

UPDATE day_schedules SET office_id = office_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from offices')
      AS t1(id int));

UPDATE activities SET office_id = office_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from offices')
      AS t1(id int));

UPDATE slots_counters SET office_id = office_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from offices')
      AS t1(id int));

UPDATE office_checks SET office_id = office_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from offices')
      AS t1(id int));

UPDATE counters SET office_id = office_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from offices')
      AS t1(id int));

UPDATE settings SET office_id = office_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from offices')
      AS t1(id int));

UPDATE offices_resources SET office_id = office_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from offices')
      AS t1(id int));

-- проставляем dictionary_id из основной базы
-- SELECT 'проставляем dictionary_id из основной базы' AS info;

-- UPDATE offices SET dictionary_id = (
-- SELECT id
--     FROM dblink('dbname=mydb', 'select id, keys -> ''code'' AS code FROM dictionaries')
--       AS t1(id int, code VARCHAR) WHERE code = (
--         SELECT keys -> 'code' AS code
--           FROM dictionaries
--             WHERE dictionaries.id = offices.dictionary_id
--       )
-- );

-- обновляем все id, которые связаны с пользователями 
SELECT 'обновляем все id, которые связаны с users' AS info;

UPDATE users SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from users')
      AS t1(id int));

UPDATE slots SET user_id = user_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from users')
      AS t1(id int));

UPDATE feedback_forms SET user_id = user_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from users')
      AS t1(id int));

UPDATE activities SET owner_id = owner_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from users')
      AS t1(id int));

UPDATE counters SET logged_in = logged_in + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from users')
      AS t1(id int))
    WHERE logged_in IS NOT NULL;

UPDATE resources_users SET user_id = user_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from users')
      AS t1(id int));

-- обновляем все id, которые связаны со slots
SELECT 'обновляем все id, которые связаны со slots' AS info;

UPDATE slots SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from slots')
      AS t1(id int));

UPDATE feedback_forms SET slot_id = slot_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from slots')
      AS t1(id int));

UPDATE slots_counters SET slot_id = slot_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from slots')
      AS t1(id int));

-- обновляем все id, которые связаны с conversation_fs
SELECT 'обновляем все id, которые связаны с conversation_fs' AS info;

UPDATE conversation_fs SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from conversation_fs')
      AS t1(id int));

-- обновляем все id, которые связаны с board_settings
SELECT 'обновляем все id, которые связаны с board_settings' AS info;

UPDATE board_settings SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from board_settings')
      AS t1(id int));

UPDATE creeping_line_patterns SET board_setting_id = board_setting_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from board_settings')
      AS t1(id int));

-- обновляем все id, которые связаны с creeping_line_patterns
SELECT 'обновляем все id, которые связаны с creeping_line_patterns' AS info;
UPDATE creeping_line_patterns SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from creeping_line_patterns')
      AS t1(id int));

-- обновляем все id, которые связаны с office_settings
SELECT 'обновляем все id, которые связаны с office_settings' AS info;

UPDATE office_settings SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from office_settings')
      AS t1(id int));

-- обновляем все id, которые связаны с portal_tickets
SELECT 'обновляем все id, которые связаны с portal_tickets' AS info;

UPDATE portal_tickets SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from portal_tickets')
      AS t1(id int));

-- обвновляем все id, которые связаны с day_schedules
SELECT 'обвновляем все id, которые связаны с day_schedules' AS info;

UPDATE day_schedules SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from day_schedules')
      AS t1(id int));

UPDATE day_schedule_resources SET day_schedule_id = day_schedule_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from day_schedules')
      AS t1(id int));

-- обвновляем все id, которые связаны с activities
SELECT 'обвновляем все id, которые связаны с activities' AS info;

UPDATE activities SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from activities')
      AS t1(id int));

-- обновляем все id, которые связаны с register_action_normatives
SELECT 'обновляем все id, которые связаны с register_action_normatives' AS info;

UPDATE register_action_normatives SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from register_action_normatives')
      AS t1(id int));

-- обвновляем все id, которые связаны с service_normatives
SELECT 'обвновляем все id, которые связаны с service_normatives' AS info;

UPDATE service_normatives SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from service_normatives')
      AS t1(id int));

-- обновляем все id, которые связаны с eq_tickets
SELECT 'обновляем все id, которые связаны с eq_tickets' AS info;

UPDATE eq_tickets SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from eq_tickets')
      AS t1(id int));

-- обновляем все id, которые связаны с unloading_events
SELECT 'обновляем все id, которые связаны с unloading_events' AS info;

UPDATE unloading_events SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from unloading_events')
      AS t1(id int));

-- обновляем все id, которые связаны с classifier_versions
SELECT 'обновляем все id, которые связаны с classifier_versions' AS info;

UPDATE classifier_versions SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from classifier_versions')
      AS t1(id int));

-- обновляем все id, которые связаны с feedback_forms
SELECT 'обновляем все id, которые связаны с feedback_forms' AS info;

UPDATE feedback_forms SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from feedback_forms')
      AS t1(id int));

-- обновляем все id, которые связаны с slots_counters
SELECT 'обновляем все id, которые связаны с slots_counters' AS info;

UPDATE slots_counters SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from slots_counters')
      AS t1(id int));

-- под вопросом
-- обновляем все id, которые связаны с classifiers
SELECT 'обновляем все id, которые связаны с classifiers' AS info;

UPDATE classifiers SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from classifiers')
      AS t1(id int));

UPDATE classifier_versions SET classifier_id = classifier_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from classifiers')
      AS t1(id int));

-- обновляем все id, которые связаны с feedback_question_answers
SELECT 'обновляем все id, которые связаны с feedback_question_answers' AS info;

UPDATE feedback_question_answers SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from feedback_question_answers')
      AS t1(id int));

-- обновляем все id, которые связаны с changes
SELECT 'обновляем все id, которые связаны с changes' AS info;

UPDATE changes SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from changes')
      AS t1(id int));

-- обновляем все id, которые связаны с client_infos
SELECT 'обновляем все id, которые связаны с client_infos' AS info;

UPDATE client_infos SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from client_infos')
      AS t1(id int));

-- обновляем все id, которые связаны с office_checks
SELECT 'обновляем все id, которые связаны с office_checks' AS info;

UPDATE office_checks SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from office_checks')
      AS t1(id int));

-- обновляем все id, которые связаны с counters
SELECT 'обновляем все id, которые связаны с counters' AS info;

UPDATE counters SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from counters')
      AS t1(id int));

UPDATE slots SET counter_id = counter_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from counters')
      AS t1(id int));

UPDATE day_schedules SET schedulable_id = schedulable_id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from counters')
      AS t1(id int));

-- обновляем все id, которые связаны с report_parameters
SELECT 'обновляем все id, которые связаны с report_parameters' AS info;

UPDATE report_parameters SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from report_parameters')
      AS t1(id int));

-- обновляем все id, которые связаны с soms_settings
SELECT 'обновляем все id, которые связаны с soms_settings' AS info;

UPDATE soms_settings SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from soms_settings')
      AS t1(id int));

-- обновляем все id, которые связаны с system_settings
SELECT 'обновляем все id, которые связаны с system_settings' AS info;

UPDATE system_settings SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from system_settings')
      AS t1(id int));

-- обновляем все id, которые связаны с documents
SELECT 'обновляем все id, которые связаны с documents' AS info;

UPDATE documents SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from documents')
      AS t1(id int));

-- обновляем все id, которые связаны с settings
SELECT 'обновляем все id, которые связаны с settings' AS info;

UPDATE settings SET id = id + (SELECT *
    FROM dblink('dbname=mydb', 'select case when max(id) is null then 0 else max(id) end from settings')
      AS t1(id int));
      
-- удаление глобальных пользователей
SELECT 'удаление глобальных пользователей' AS info;

-- UPDATE users SET email=CONCAT('admin', CAST(id AS VARCHAR),'@admin.ru') WHERE email='admin@admin.ru';
UPDATE users SET state='deleted', email=CONCAT(CAST((select properties -> 'code' AS code FROM dictionaries WHERE id=(SELECT dictionary_id FROM offices LIMIT 1)) AS VARCHAR), email) WHERE roles_mask = 4 OR roles_mask = 8 OR roles_mask = 12;

-- обновление email-ов пользователям с дублирующимися email-ами
SELECT 'обновление email-ов пользователям с дублирующимися email-ами' AS info;
UPDATE users SET email=CONCAT('a', CAST(id AS VARCHAR),CAST(email AS VARCHAR)) WHERE
	email IN (SELECT email FROM dblink('dbname=mydb', 'select email from users')
      AS t1(email VARCHAR));

-- удаление глобальных пользователей
-- SELECT 'удаление глобальных пользователей';
-- DELETE FROM users WHERE roles_mask = 4 OR roles_mask = 8 OR roles_mask = 12;

-- удаление "плохих" талонов
SELECT 'удаление "плохих" талонов' AS info;
DELETE FROM slots WHERE created_at >= CURRENT_DATE AND status != 'ready' AND status != 'not_come' AND status != 'denial_service';

-- обновление типов офисов на центральные
SELECT 'обновление типов офисов на центральные' AS info;
UPDATE offices SET remote_instance=false;

-- 'удаление ненужных таблиц'
SELECT 'таблица dictionaries больше не нужна' AS info;
DROP TABLE dictionaries;

-- SELECT 'таблица activities больше не нужна' AS info;
-- DROP TABLE activities;

SELECT id, name, region FROM offices;
