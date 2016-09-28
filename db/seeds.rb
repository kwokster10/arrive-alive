# Create an admin user
admin = User.create(email: 'admin@arrive-alive.com', password: 'password', password_confirmation: 'password', admin: true, name: 'Admin', phone_number: '555-555-5555')

# Create a couple of non-admin user
skipper = User.create(email: 'skipper@arrive-alive.com', password: 'password', password_confirmation: 'password', admin: true, name: 'Skipper', phone_number: '555-555-5555')

guppy = User.create(email: 'guppy@arrive-alive.com', password: 'password', password_confirmation: 'password', admin: true, name: 'Guppy', phone_number: '555-555-5555')

# Creates a couple float plans
FloatPlan.create(
  [
    {
      name: 'First Test',
      start_time: DateTime.now + 1.hour,
      arrival_time: DateTime.now + 3.hours,
      start_location: 'MyString',
      arrival_location: 'MyString',
      boat_number: 10,
      email: 'MyString@test.com',
      phone_number: '1234567890',
      participants: [
        {
          name: 'Member',
          is_member: true},
        {
          name: 'Guest',
          is_member: false}
      ].to_json,
      direction_of_sail: 'North',
      current: 'ebb',
      had_vhf_radio: true,
      had_three_flares: true,
      had_throw_rope: true,
      had_checked_weather: true,
      user_id: admin,
      state: 1,
      notes: 'MyText'},
    {
      name: 'Second Test',
      start_time: DateTime.now + 2.hours,
      arrival_time: DateTime.now + 5.hours,
      start_location: 'MyString',
      arrival_location: 'MyString',
      boat_number: 10,
      email: 'MyString@test.com',
      phone_number: '1234567890',
      participants: [
        {
          name: 'Member',
          is_member: true},
        {
          name: 'Guest',
          is_member: false}
      ].to_json,
      direction_of_sail: 'south',
      current: 'flood',
      had_vhf_radio: true,
      had_three_flares: true,
      had_throw_rope: true,
      had_checked_weather: true,
      user_id: skipper,
      state: 0,
      notes: 'MyText'
    },
    {
      name: 'Third Test',
      start_time: DateTime.now - 2.hours,
      arrival_time: DateTime.now + 2.hours,
      start_location: 'MyString',
      arrival_location: 'MyString',
      boat_number: 2,
      email: 'MyString@test.com',
      phone_number: '1234567890',
      participants: [
        {
          name: 'Member',
          is_member: true},
        {
          name: 'Guest',
          is_member: false}
      ].to_json,
      direction_of_sail: 'south',
      current: 'flood',
      had_vhf_radio: true,
      had_three_flares: true,
      had_throw_rope: true,
      had_checked_weather: true,
      user_id: guppy,
      state: 1,
      notes: 'MyText'
    }
  ]
)
