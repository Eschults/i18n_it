# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
en = Language.create(language_key: 'en')
fr = Language.create(language_key: 'fr')
es = Language.create(language_key: 'es')

pp = Company.create(company_name: 'PurProjet')

p1 = pp.projects.build(project_name: 'Alto Huayabamba')
p2 = pp.projects.build(project_name: 'Alto Shamboyacu')
p3 = pp.projects.build(project_name: 'Pur Hexagone')

p1.save
p2.save
p3.save

p1.languages << en
p1.languages << fr
p1.languages << es

p2.languages << en
p2.languages << fr
p2.languages << es

p3.languages << en
p3.languages << fr
p3.languages << es
