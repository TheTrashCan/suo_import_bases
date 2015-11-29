-- в базе foo1

UPDATE services SET parent_id = parent_id + (SELECT *
  FROM dblink('dbname=suo_history', 'select case when max(id) is null then 0 else max(id) end from services_history')
    AS t1(id int));

UPDATE resources SET service_id = service_id + (SELECT *
  FROM dblink('dbname=suo_history', 'select case when max(id) is null then 0 else max(id) end from services_history')
    AS t2(id int));

UPDATE slots SET resource_id = resource_id + (SELECT *
  FROM dblink('dbname=suo_history', 'select case when max(id) is null then 0 else max(id) end from resources_history')
    AS t3(id int));