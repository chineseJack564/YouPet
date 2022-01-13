# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password',
                  password_confirmation: 'password')

user1 = User.create!(username: 'Benja', email: '1@uc.cl', password: '123456',
                     password_confirmation: '123456', unread_notifications: 1)

user2 = User.create!(username: 'Jack', email: '2@uc.cl', password: '123456',
                     password_confirmation: '123456', unread_notifications: 1)

p1=Post.new(user_id: user1.id, title: 'Perro tierno', specie: 0,
                     breed: 'Dog', post_type: 0, address: 'Campus San Joaquin',
                     coord_x: -33.49935403281778, coord_y: -70.61425558285272,
                     description: 'He is a good boy!').save!(validate: false)
post1=Post.find(1)
post1.avatar_main.attach(io: File.open('public/dog1.png'), filename: 'dog1.png')
p2=Post.new(user_id: user2.id, title: 'Perro dormiton', specie: 2,
                     breed: 'Cat', post_type: 0, address: 'Campus San Joaquin',
                     pictures: 'https://upload.wikimedia.org/wikipedia/commons/c/c7/Tabby_cat_with_blue_eyes-3336579.jpg',
                     coord_x: -33.49935403281778, coord_y: -70.61425558285272,
                     description: 'She is a Bad girl!').save!(validate: false)
post2=Post.find(2)           
post2.avatar_main.attach(io: File.open('public/dog2.png'), filename: 'dog2.png')
com1 = Comment.create!(post_id: post2.id, title: 'La quiero', content: 'Esta demnasiado lindo!',
                       sender_id: user1.id)
not1 = Notification.create!(to_id: user2.id, from_id: user1.id, notificator: com1, user?: true, unread?: true)

rly1 = Reply.create!(comment_id: com1.id, sender_id: user2.id, content: 'Gracias!!')
com2 = Comment.create!(post_id: post2.id, title: 'Love her', content: 'Esta demnasiado lindaaaa!',
                       sender_id: user1.id)
rly2 = Reply.create!(comment_id: com2.id, sender_id: user2.id, content: 'Gracias tu igual!!')

order1 = Order.create!(post_id: post1.id, user_id: user2.id, status: 'pending',
                       body: 'Me lo llevo')
not2 = Notification.create!(to_id: user1.id, from_id: user2.id, notificator: order1, user?: false, unread?: true)
order2 = Order.create!(post_id: post2.id, user_id: user1.id, status: 'pending',
                       body: 'Me lo llevo de una')

revw1 = Review.create!(sender_id: user1.id, recipient_id: user2.id, title: 'Buena persona',
                       content: 'Trata bien a los animales', score: 4, anon: 0)

revw2 = Review.create!(sender_id: user2.id, recipient_id: user1.id, title: 'Buena persona',
                       content: 'Trata bien a los animales', score: 4, anon: 0)
