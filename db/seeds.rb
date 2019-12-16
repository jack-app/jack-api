# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'bcrypt'

User.create(
  slack_id: 'XXXXXXXX',
  github_id: 'YYYYYYYY',
  nickname: 'ジャクロウ',
  email: 'jack.taro@example.com',
  first_name: 'ジャック',
  last_name: '太郎',
  slack_image: '',
  auth_token: BCrypt::Password.create('securetoken'),
  is_admin: false,
  is_enterable_library: false,
  repeat_year: 0
)