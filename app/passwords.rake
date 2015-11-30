namespace :passwords do
  task :generate => :environment do
    lastid = Office.maximum("id")

    f = File.new("pas_id_#{lastid}", 'w')

    f.write("Office id: #{lastid}\n\n")

    User.where(office_id: lastid, state: "active").find_each do |u|
      psw = ([*('A'..'Z'), *('0'..'9')]-%w(0 1 I O)).sample(8).join
      office = u.office_id.nil? ? " " : u.office.name
      f.write("office: #{office} fio: #{u.first_name} #{u.middle_name} #{u.last_name} email: #{u.email} password: #{psw}\n\n")
      u.password = psw
      u.password_confirmation = psw
      u.save
    end

    office = Office.find(lastid)
    psw = ([*('A'..'Z'), *('0'..'9')]-%w(0 1 I O)).sample(8).join
    u = User.create
    u.post = 'Локальный администратор'
    u.state = 'active'
    u.email = "local#{office.dictionary.properties['code']}@admin.ru"
    u.sign_in_count = 0
    u.roles_mask = 2
    u.first_name = 'Администратор'
    u.middle_name = 'Офиса'
    u.last_name = 'Локальный'
    u.office_id = office.id
    u.password = psw
    u.password_confirmation = psw
    u.save
    office = u.office_id.nil? ? " " : u.office.name
    f.write("office: #{office} fio: #{u.first_name} #{u.middle_name} #{u.last_name} email: #{u.email} password: #{psw}\n\n")
  end

  task :admins => :environment do
    ids = [317, 325, 327, 326, 315, 319, 320, 316, 328, 324, 321, 322, 323]
    f = File.new("admins_pass", 'w')

    ids.each do |office_id|
      office = Office.find(office_id)
      f.write("Office id: #{office_id}\n\n")
      psw = ([*('A'..'Z'), *('0'..'9')]-%w(0 1 I O)).sample(8).join
      u = User.create
      u.post = 'Локальный администратор'
      u.state = 'active'
      u.email = "local#{office.dictionary.properties['code']}@admin.ru"
      u.sign_in_count = 0
      u.roles_mask = 2
      u.first_name = 'Администратор'
      u.middle_name = 'Офиса'
      u.last_name = 'Локальный'
      u.office_id = office.id
      u.password = psw
      u.password_confirmation = psw
      u.save
      office = u.office_id.nil? ? " " : u.office.name
      f.write("office: #{office} fio: #{u.first_name} #{u.middle_name} #{u.last_name} email: #{u.email} password: #{psw}\n\n")
    end
  end
end
