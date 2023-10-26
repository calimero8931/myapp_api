if Rails.env.production?

  10.times do |n|
    name = "user#{n}"
    email = "#{name}@example.com"
    user = User.find_or_initialize_by(email: email, activated: true)

    if user.new_record?
      user.name = name
      user.password = "password"
      user.save!
    end
  end

  puts "users = #{User.count}"


  1.times do |n|
    name = "日本"
    created_at = Time.now
    updated_at = Time.now
    country = Country.find_or_initialize_by(name: name, created_at: created_at, updated_at: updated_at)
    country.save!
  end

  puts "countries = #{Country.count}"

  # categoryのsql文
  sql = <<-SQL
  INSERT INTO categories (name, created_at, updated_at)
    VALUES ('観光', NOW(), NOW()),('食べ物', NOW(), NOW());
  SQL
  ActiveRecord::Base.connection.execute(sql)

  1.upto(30) do |n|
    name = "sub_category#{n}"
    category_id = rand(1..2)
    sub_category = SubCategory.find_or_initialize_by(name: name , category_id: category_id)

    if sub_category.new_record?
      sub_category.save!
    end
  end

  puts "sub_categories = #{SubCategory.count}"

  # regionを挿入するSQL文
  sql = <<-SQL
  INSERT INTO regions (name, country_id, created_at, updated_at) VALUES ('北海道', 1, now(), now()),
  ('東北', 1, now(), now()), ('関東', 1, now(), now()), ('中部', 1, now(), now()), ('近畿', 1, now(), now()), ('中国・四国', 1, now(), now()),
  ('九州', 1, now(), now());
  SQL
  ActiveRecord::Base.connection.execute(sql)

  # prefecturesを挿入するSQL文
  sql = <<-SQL
  INSERT INTO prefectures (name, region_id, created_at, updated_at) VALUES
  ('北海道', 1, now(), now()),
  ('青森県', 2, now(), now()),
  ('岩手県', 2, now(), now()),
  ('宮城県', 2, now(), now()),
  ('秋田県', 2, now(), now()),
  ('山形県', 2, now(), now()),
  ('福島県', 2, now(), now()),
  ('東京都', 3, now(), now()),
  ('神奈川県', 3, now(), now()),
  ('埼玉県', 3, now(), now()),
  ('千葉県', 3, now(), now()),
  ('茨城県', 3, now(), now()),
  ('栃木県', 3, now(), now()),
  ('群馬県', 3, now(), now()),
  ('山梨県', 3, now(), now()),
  ('新潟県', 4, now(), now()),
  ('長野県', 4, now(), now()),
  ('富山県', 4, now(), now()),
  ('石川県', 4, now(), now()),
  ('福井県', 4, now(), now()),
  ('岐阜県', 4, now(), now()),
  ('静岡県', 4, now(), now()),
  ('愛知県', 4, now(), now()),
  ('三重県', 4, now(), now()),
  ('滋賀県', 5, now(), now()),
  ('京都府', 5, now(), now()),
  ('大阪府', 5, now(), now()),
  ('兵庫県', 5, now(), now()),
  ('奈良県', 5, now(), now()),
  ('和歌山県', 5, now(), now()),
  ('鳥取県', 6, now(), now()),
  ('島根県', 6, now(), now()),
  ('岡山県', 6, now(), now()),
  ('広島県', 6, now(), now()),
  ('山口県', 6, now(), now()),
  ('徳島県', 6, now(), now()),
  ('香川県', 6, now(), now()),
  ('愛媛県', 6, now(), now()),
  ('高知県', 6, now(), now()),
  ('福岡県', 7, now(), now()),
  ('佐賀県', 7, now(), now()),
  ('長崎県', 7, now(), now()),
  ('熊本県', 7, now(), now()),
  ('大分県', 7, now(), now()),
  ('宮崎県', 7, now(), now()),
  ('鹿児島県', 7, now(), now()),
  ('沖縄県', 7, now(), now());
  SQL
  ActiveRecord::Base.connection.execute(sql)

  1.upto(30) do |n|
    title = "trophy#{n}"
    description = "description#{n}"
    create_user_id = 1
    created_at = Time.now
    updated_at = Time.now
    latitude = rand(1..100)
    longitude = rand(1..100)
    image_url = "image#{n}"
    country_id = 1
    category_id = rand(1..3)
    region_id = 1
    prefecture_id = 1

    trophy = Trophy.find_or_initialize_by(title: title, description: description, create_user_id: create_user_id, created_at: created_at, updated_at: updated_at, latitude: latitude, longitude: longitude, image_url: image_url, country_id: country_id, category_id: category_id, region_id: region_id, prefecture_id: prefecture_id )

    if trophy.new_record?
      trophy.save!
    end
  end

  puts "trophies = #{Trophy.count}"
end

if Rails.env.development?# 本番環境用のシーディングデータ

  # ...
end