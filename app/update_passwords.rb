f = File.new("passwords", 'w')

lastid = Office.maximum("id")

#User.all.each do |u|
User.where(office_id: lastid).find_each do |u|
  psw = ([*('A'..'Z'), *('0'..'9')]-%w(0 1 I O)).sample(8).join
  office = u.office_id.nil? ? " " : u.office.name
  f.write("office: #{office} fio: #{u.first_name} #{u.middle_name} #{u.last_name} email: #{u.email} password: #{psw}\n\n")
  u.password = psw
  u.password_confirmation = psw
  u.save
end
