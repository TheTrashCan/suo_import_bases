CREATE EXTENSION hstore;

CREATE TABLE security_images (
  id          integer,
  file        character varying(255),
  active      boolean,
  created_at  timestamp without time zone,
  updated_at  timestamp without time zone
);

CREATE TABLE schema_migrations (
  version  character varying
);

CREATE TABLE mortgage_types (
  id          integer,
  name        character varying(255),
  slug        character varying(255),
  created_at  timestamp without time zone,
  updated_at  timestamp without time zone
);

CREATE TABLE activities (
  id              integer,
  trackable_id    integer,
  trackable_type  character varying(255),
  owner_id        integer,
  owner_type      character varying(255),
  key             character varying(255),
  parameters      text,
  recipient_id    integer,
  recipient_type  character varying(255),
  created_at      timestamp without time zone,
  updated_at      timestamp without time zone,
  office_id       integer
);

CREATE TABLE additional_service_times (
  id               integer,
  service_id       integer,
  object_count     integer,
  additional_time  integer,
  created_at       timestamp without time zone,
  updated_at       timestamp without time zone
);

CREATE TABLE applicant_types (
  id          integer,
  name        character varying(255),
  slug        character varying(255),
  created_at  timestamp without time zone,
  updated_at  timestamp without time zone
);

CREATE TABLE board_settings (
  id                           integer,
  rows                         integer,
  number_of_columns            integer,
  header_1                     character varying(255),
  use_header_1                 boolean,
  header_2                     character varying(255),
  use_header_2                 boolean,
  use_sound_notification       boolean,
  use_voice_notification       boolean,
  use_video                    boolean,
  use_creeping_line            boolean,
  office_id                    integer,
  created_at                   timestamp without time zone,
  updated_at                   timestamp without time zone,
  color_scheme                 character varying(255),
  use_rss                      boolean,
  uuid                         character varying(255),
  hide_slot_and_window_number  boolean
);

CREATE TABLE changes (
  id          integer,
  uuid        character varying(255),
  entity      character varying(255),
  action      character varying(255),
  created_at  timestamp without time zone,
  updated_at  timestamp without time zone
);

CREATE TABLE classifier_versions (
  id             integer,
  code           character varying(255),
  name           character varying(255),
  last_revision  character varying(255),
  state          character varying(255),
  classifier_id  integer,
  created_at     timestamp without time zone,
  updated_at     timestamp without time zone
);

CREATE TABLE classifiers (
  id             integer,
  code           character varying(255),
  name           character varying(255),
  last_revision  character varying(255),
  created_at     timestamp without time zone,
  updated_at     timestamp without time zone,
  imported_at    timestamp without time zone
);

CREATE TABLE client_infos (
  id           integer,
  ip           character varying(255),
  info         text,
  created_at   timestamp without time zone,
  updated_at   timestamp without time zone,
  client_type  character varying(255)
);

CREATE TABLE conversation_fs (
  id                 integer,
  service_date       timestamp without time zone,
  service_id         integer,
  resource_id        integer,
  status             character varying(255),
  region             character varying(255),
  subject            character varying(255),
  district           character varying(255),
  office             character varying(255),
  personal           boolean,
  wild_queue         boolean,
  source_id          integer,
  start_time         timestamp without time zone,
  end_time           timestamp without time zone,
  name               character varying(255),
  passport_number    character varying(255),
  passport_series    character varying(255),
  objects_count      integer,
  organization_name  character varying(255),
  ogrn               bigint,
  inn                bigint,
  kpp                integer,
  schedule_id        integer,
  created_at         timestamp without time zone,
  updated_at         timestamp without time zone,
  external_id        integer,
  duration           integer,
  service_name       character varying(255),
  process_out        integer,
  get_out            integer
);

CREATE TABLE counters (
  id             integer,
  name           character varying(255),
  logged_in      integer,
  tablo_address  character varying(255),
  office_id      integer,
  uuid           character varying(255)
);

CREATE TABLE creeping_line_patterns (
  id                integer,
  board_setting_id  integer,
  pattern           character varying(255),
  checked           boolean,
  created_at        timestamp without time zone,
  updated_at        timestamp without time zone
);

CREATE TABLE day_schedule_resources (
  day_schedule_id  integer,
  resource_id      integer
);

CREATE TABLE dictionaries (
  id          integer,
  name        text,
  keys        hstore,
  properties  hstore,
  created_at  timestamp without time zone,
  updated_at  timestamp without time zone,
  key         text
);

CREATE TABLE documents (
  id            integer,
  code          character varying(255),
  service_code  character varying(255),
  name          text,
  status        character varying(255)
);

CREATE TABLE eq_tickets (
  id           integer,
  asvz_id      integer,
  num          character varying(255),
  inserted     date,
  rec_start    integer,
  rec_end      integer,
  queue_namer  character varying(255),
  status       character varying(255),
  office       character varying(255),
  rec_date     date
);

CREATE TABLE feedback_forms (
  id              integer,
  slot_id         integer,
  created_at      timestamp without time zone,
  updated_at      timestamp without time zone,
  mark            integer,
  feedback_panel  boolean,
  user_id         integer
);

CREATE TABLE feedback_question_answers (
  id                    integer,
  feedback_question_id  integer,
  feedback_form_id      integer,
  mark                  integer,
  created_at            timestamp without time zone,
  updated_at            timestamp without time zone
);

CREATE TABLE feedback_questions (
  id          integer,
  question    character varying(255),
  created_at  timestamp without time zone,
  updated_at  timestamp without time zone
);

CREATE TABLE instance_types (
  central  boolean
);

CREATE TABLE office_checks (
  id          integer,
  code        character varying(255),
  value       character varying(255),
  office_id   integer,
  created_at  timestamp without time zone,
  updated_at  timestamp without time zone
);

CREATE TABLE office_settings (
  id                                  integer,
  interval_between_call               integer,
  recalls_count                       integer,
  booking_server_url                  character varying(255),
  use_client_counter                  boolean,
  office_without_terminal             boolean,
  office_id                           integer,
  created_at                          timestamp without time zone,
  updated_at                          timestamp without time zone,
  time_zone                           character varying(255),
  uuid                                character varying(255),
  no_booking                          boolean,
  security_image_id                   integer,
  org_name                            character varying(255),
  footnote                            character varying(255),
  individual_call                     boolean,
  hide_fio_in_prerecord_mode          boolean,
  hide_fio_in_live_mode               boolean,
  hide_passport_in_prerecord_mode     boolean,
  hide_passport_in_live_mode          boolean,
  terminal_inactivity_timeout         integer,
  max_appointments_for_user           integer,
  max_objects_count                   integer,
  hide_objects_count_in_talon         boolean,
  hide_object_type_in_prerecord_mode  boolean,
  hide_object_type_in_live_mode       boolean
);

CREATE TABLE offices (
  id                    integer,
  name                  text,
  number                integer,
  region                text,
  created_at            timestamp without time zone,
  updated_at            timestamp without time zone,
  dictionary_id         integer,
  no_terminal           boolean,
  uuid                  character varying(255),
  remote_instance       boolean,
  rr_booking            boolean,
  office_asvz           boolean,
  active                boolean,
  asvz_office_id        integer,
  code                  character varying,
  use_central_playlist  boolean
);

CREATE TABLE offices_resources (
  resource_id  integer,
  office_id    integer
);

CREATE TABLE portal_tickets_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);

CREATE TABLE register_action_normatives (
  id                   integer,
  applicant_type_id    integer,
  supplying_method_id  integer,
  calendar_days        integer,
  work_days            integer,
  norm_deviation       integer,
  bad_deviation        integer,
  created_at           timestamp without time zone,
  updated_at           timestamp without time zone,
  register_action_id   integer
);

CREATE TABLE register_actions (
  id                   integer,
  name                 character varying(255),
  register_actions_id  integer,
  created_at           timestamp without time zone,
  updated_at           timestamp without time zone
);

CREATE TABLE report_parameters (
  id          integer,
  name        character varying(255),
  code        character varying(255),
  created_at  timestamp without time zone,
  updated_at  timestamp without time zone
);

CREATE TABLE reports (
  id                     integer,
  name                   character varying(255),
  template_file_name     character varying(255),
  template_content_type  character varying(255),
  template_file_size     integer,
  template_updated_at    timestamp without time zone
);

CREATE TABLE resources (
  id                    integer,
  name                  character varying(255),
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
);

CREATE TABLE resources_users (
  resource_id  integer,
  user_id      integer
);

CREATE TABLE service_frgus (
  id                integer,
  name              character varying(255),
  service_frgus_id  integer,
  created_at        timestamp without time zone,
  updated_at        timestamp without time zone
);

CREATE TABLE service_normatives (
  id                   integer,
  supplying_method_id  integer,
  mortgage_type_id     integer,
  calendar_days        integer,
  work_days            integer,
  norm_deviation       integer,
  bad_deviation        integer,
  created_at           timestamp without time zone,
  updated_at           timestamp without time zone,
  service_frgu_id      integer
);

CREATE TABLE services (
  id            integer,
  code          character varying(255),
  name          text,
  visible       boolean,
  status        character varying(255),
  letter_code   character varying(255),
  short_name    text,
  service_time  integer,
  parent_id     integer
);

CREATE TABLE settings (
  id         integer,
  code       character varying(255),
  val        text,
  office_id  integer
);

CREATE TABLE slots (
  id                    integer,
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
);

CREATE TABLE slots_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);

CREATE TABLE slots_history_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);

CREATE TABLE soms_settings (
  id          integer,
  name        character varying(255),
  value       character varying(255),
  created_at  timestamp without time zone,
  updated_at  timestamp without time zone
);

CREATE TABLE sources (
  id          integer,
  name        character varying(255),
  created_at  timestamp without time zone,
  updated_at  timestamp without time zone
);

CREATE TABLE supplying_methods (
  id          integer,
  name        character varying(255),
  slug        character varying(255),
  created_at  timestamp without time zone,
  updated_at  timestamp without time zone
);

CREATE TABLE system_settings (
  id          integer,
  code        character varying(255),
  value       character varying(255),
  created_at  timestamp without time zone,
  updated_at  timestamp without time zone
);

CREATE TABLE unloading_events (
  id              integer,
  event           character varying(255),
  event_date      date,
  state           character varying(255),
  asvz_office_id  character varying(255),
  unloading_rows  integer,
  created_at      timestamp without time zone,
  updated_at      timestamp without time zone
);

CREATE TABLE users (
  id                      integer,
  name                    character varying(255),
  post                    character varying(255),
  note                    text,
  state                   character varying(255),
  email                   character varying(255),
  encrypted_password      character varying(255),
  reset_password_token    character varying(255),
  reset_password_sent_at  timestamp without time zone,
  remember_created_at     timestamp without time zone,
  sign_in_count           integer,
  current_sign_in_at      timestamp without time zone,
  last_sign_in_at         timestamp without time zone,
  current_sign_in_ip      character varying(255),
  last_sign_in_ip         character varying(255),
  roles_mask              integer,
  last_name               character varying(255),
  middle_name             character varying(255),
  first_name              character varying(255),
  office_id               integer,
  uuid                    character varying(255)
);

CREATE TABLE slots_counters (
  id            integer,
  slot_id       integer,
  office_id     integer,
  counter_name  character varying(255),
  start_time    timestamp without time zone,
  end_time      timestamp without time zone,
  number        character varying(255)
);

-- here it goes again
CREATE TABLE activities_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);

CREATE TABLE board_settings_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);

CREATE TABLE changes_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);
                                 
CREATE TABLE classifier_versions_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);

CREATE TABLE classifiers_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);

CREATE TABLE client_infos_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);

CREATE TABLE conversation_fs_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);

CREATE TABLE counters_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);
                                 
                                 
CREATE TABLE day_schedules (
  id              integer,
  wday            integer,
  "from"          integer,
  till            integer,
  schedulable_id  integer,
  exception       boolean,
  exception_day   timestamp without time zone,
  resource_id     integer,
  office_id       integer,
  uuid            character varying(255),
  day             date,
  holiday         boolean
);
        
CREATE TABLE dictionaries_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);

CREATE TABLE documents_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);

CREATE TABLE eq_tickets_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);

CREATE TABLE feedback_forms_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);

CREATE TABLE feedback_question_answers_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);

CREATE TABLE office_checks_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);

CREATE TABLE office_settings_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);
                                 
CREATE TABLE offices_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);
                                 
CREATE TABLE portal_tickets (
  id           integer,
  custom_id    integer,
  dept_id      integer,
  queue_id     integer,
  number       character varying(255),
  date         character varying(255),
  time         integer,
  duration     integer,
  houses       integer,
  applicants   integer,
  treatment    integer,
  member_fio   character varying(255),
  member_info  character varying(255)
);

CREATE TABLE register_action_normatives_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);

CREATE TABLE report_parameters_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);
                                 
CREATE TABLE service_normatives_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);

CREATE TABLE settings_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);

CREATE TABLE soms_settings_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);

CREATE TABLE system_settings_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);

CREATE TABLE unloading_events_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);
                                 
CREATE TABLE users_id_seq (
  sequence_name  name,
  last_value     bigint,
  start_value    bigint,
  increment_by   bigint,
  max_value      bigint,
  min_value      bigint,
  cache_value    bigint,
  log_cnt        bigint,
  is_cycled      boolean,
  is_called      boolean
);
