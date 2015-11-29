SELECT CASE WHEN max(id) IS NOT NULL
  THEN setval('activities_id_seq', max(id))
       ELSE 0 END
FROM activities;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('additional_service_times_id_seq', max(id))
       ELSE 0 END
FROM additional_service_times;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('applicant_types_id_seq', max(id))
       ELSE 0 END
FROM applicant_types;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('board_settings_id_seq', max(id))
       ELSE 0 END
FROM board_settings;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('changes_id_seq', max(id))
       ELSE 0 END
FROM changes;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('classifier_versions_id_seq', max(id))
       ELSE 0 END
FROM classifier_versions;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('classifiers_id_seq', max(id))
       ELSE 0 END
FROM classifiers;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('client_infos_id_seq', max(id))
       ELSE 0 END
FROM client_infos;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('conversation_fs_id_seq', max(id))
       ELSE 0 END
FROM conversation_fs;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('counters_id_seq', max(id))
       ELSE 0 END
FROM counters;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('creeping_line_patterns_id_seq', max(id))
       ELSE 0 END
FROM creeping_line_patterns;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('day_schedules_id_seq', max(id))
       ELSE 0 END
FROM day_schedules;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('dictionaries_id_seq', max(id))
       ELSE 0 END
FROM dictionaries;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('documents_id_seq', max(id))
       ELSE 0 END
FROM documents;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('eq_tickets_id_seq', max(id))
       ELSE 0 END
FROM eq_tickets;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('feedback_forms_id_seq', max(id))
       ELSE 0 END
FROM feedback_forms;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('feedback_question_answers_id_seq', max(id))
       ELSE 0 END
FROM feedback_question_answers;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('feedback_questions_id_seq', max(id))
       ELSE 0 END
FROM feedback_questions;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('mortgage_types_id_seq', max(id))
       ELSE 0 END
FROM mortgage_types;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('office_checks_id_seq', max(id))
       ELSE 0 END
FROM office_checks;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('office_settings_id_seq', max(id))
       ELSE 0 END
FROM office_settings;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('offices_id_seq', max(id))
       ELSE 0 END
FROM offices;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('portal_tickets_id_seq', max(id))
       ELSE 0 END
FROM portal_tickets;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('register_action_normatives_id_seq', max(id))
       ELSE 0 END
FROM register_action_normatives;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('register_actions_id_seq', max(id))
       ELSE 0 END
FROM register_actions;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('report_parameters_id_seq', max(id))
       ELSE 0 END
FROM report_parameters;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('reports_id_seq', max(id))
       ELSE 0 END
FROM reports;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('resources_id_seq', max(id))
       ELSE 0 END
FROM resources;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('security_images_id_seq', max(id))
       ELSE 0 END
FROM security_images;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('service_frgus_id_seq', max(id))
       ELSE 0 END
FROM service_frgus;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('service_normatives_id_seq', max(id))
       ELSE 0 END
FROM service_normatives;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('services_id_seq', max(id))
       ELSE 0 END
FROM services;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('settings_id_seq', max(id))
       ELSE 0 END
FROM settings;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('slots_counters_id_seq', max(id))
       ELSE 0 END
FROM slots_counters;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('slots_id_seq', max(id))
       ELSE 0 END
FROM slots;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('soms_settings_id_seq', max(id))
       ELSE 0 END
FROM soms_settings;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('sources_id_seq', max(id))
       ELSE 0 END
FROM sources;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('supplying_methods_id_seq', max(id))
       ELSE 0 END
FROM supplying_methods;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('system_settings_id_seq', max(id))
       ELSE 0 END
FROM system_settings;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('unloading_events_id_seq', max(id))
       ELSE 0 END
FROM unloading_events;

SELECT CASE WHEN MAX(id) IS NOT NULL
  THEN setval('users_id_seq', max(id))
       ELSE 0 END
FROM users;
