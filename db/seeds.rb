categories = [
  { name: "Laptops", description: "Laptops for work, school and gaming." },
  { name: "Monitors", description: "Computer monitors and displays." },
  { name: "Keyboards", description: "Computer keyboards and accessories." },
  { name: "Accessories", description: "Computer accessories and peripherals." }
]

categories.each do |category|
  Category.find_or_create_by!(name: category[:name]) do |new_category|
    new_category.description = category[:description]
  end
end

products = [
  {
    sku: "LAP-001",
    name: "Dell XPS 13",
    description: "Compact laptop with an Intel Core processor, high-resolution display and lightweight design for productivity.",
    brand: "Dell",
    current_price: 1299.99,
    stock_quantity: 10,
    category: "Laptops"
  },
  {
    sku: "LAP-002",
    name: "Apple MacBook Air M3",
    description: "Lightweight Apple laptop featuring the M3 chip, Retina display and long battery life.",
    brand: "Apple",
    current_price: 1399.99,
    stock_quantity: 8,
    category: "Laptops"
  },
  {
    sku: "LAP-003",
    name: "Lenovo ThinkPad E14",
    description: "Business laptop designed for everyday office work, productivity and professional use.",
    brand: "Lenovo",
    current_price: 1099.99,
    stock_quantity: 12,
    category: "Laptops"
  },
  {
    sku: "MON-001",
    name: "Samsung 27-inch Monitor",
    description: "27-inch computer monitor designed for everyday computing, entertainment and office productivity.",
    brand: "Samsung",
    current_price: 279.99,
    stock_quantity: 15,
    category: "Monitors"
  },
  {
    sku: "MON-002",
    name: "LG UltraGear 27-inch",
    description: "Gaming monitor with a high refresh rate and responsive display for smooth gaming.",
    brand: "LG",
    current_price: 399.99,
    stock_quantity: 7,
    category: "Monitors"
  },
  {
    sku: "KEY-001",
    name: "Logitech MX Keys S",
    description: "Wireless keyboard with comfortable low-profile keys and multi-device connectivity.",
    brand: "Logitech",
    current_price: 139.99,
    stock_quantity: 20,
    category: "Keyboards"
  },
  {
    sku: "KEY-002",
    name: "Corsair K70 RGB",
    description: "Mechanical gaming keyboard featuring customizable RGB lighting and responsive switches.",
    brand: "Corsair",
    current_price: 189.99,
    stock_quantity: 9,
    category: "Keyboards"
  },
  {
    sku: "ACC-001",
    name: "Logitech MX Master 3S",
    description: "Wireless ergonomic mouse with customizable buttons and precision tracking.",
    brand: "Logitech",
    current_price: 119.99,
    stock_quantity: 18,
    category: "Accessories"
  },
  {
    sku: "ACC-002",
    name: "Samsung T7 Portable SSD 1TB",
    description: "Portable solid-state drive offering fast data transfers and compact external storage.",
    brand: "Samsung",
    current_price: 149.99,
    stock_quantity: 14,
    category: "Accessories"
  },
  {
    sku: "ACC-003",
    name: "Anker 7-in-1 USB-C Hub",
    description: "Multiport USB-C adapter providing additional connectivity for compatible laptops.",
    brand: "Anker",
    current_price: 69.99,
    stock_quantity: 25,
    category: "Accessories"
  }
]


# Generate 90 additional products across the four categories.
generated_products = {
  "Laptops" => ["Dell", "Lenovo", "HP", "Acer", "ASUS", "Apple"],
  "Monitors" => ["Samsung", "LG", "Dell", "Acer", "ASUS", "BenQ"],
  "Keyboards" => ["Logitech", "Corsair", "Razer", "Keychron", "SteelSeries", "Microsoft"],
  "Accessories" => ["Anker", "Logitech", "Samsung", "Belkin", "TP-Link", "Kingston"]
}

product_types = {
  "Laptops" => ["Business Laptop", "Pro Laptop", "Slim Laptop", "Student Laptop"],
  "Monitors" => ["Full HD Monitor", "4K Monitor", "Gaming Monitor", "IPS Monitor"],
  "Keyboards" => ["Wireless Keyboard", "Mechanical Keyboard", "RGB Keyboard", "Compact Keyboard"],
  "Accessories" => ["USB-C Hub", "Wireless Mouse", "Portable SSD", "Webcam", "Laptop Stand", "USB Adapter"]
}

index = 1
generated_products.each do |category_name, brands|
  23.times do |i|
    brand = brands[i % brands.length]
    type = product_types[category_name][i % product_types[category_name].length]
    model = "Series #{i + 1}"
    products << {
      sku: "AUTO-%03d" % index,
      name: "#{brand} #{type} #{model}",
      description: "#{brand} #{type.downcase} designed for reliable everyday computing, productivity and performance.",
      brand: brand,
      current_price: (49.99 + (index * 13.5) % 950).round(2),
      stock_quantity: 5 + (index % 26),
      category: category_name
    }
    index += 1
  end
end

products.each do |product_data|
  category = Category.find_by!(name: product_data[:category])

  product = Product.find_or_initialize_by(sku: product_data[:sku])

  product.assign_attributes(
    name: product_data[:name],
    description: product_data[:description],
    brand: product_data[:brand],
    current_price: product_data[:current_price],
    stock_quantity: product_data[:stock_quantity],
    active: true,
    category: category
  )

  product.save!
end

puts "Created #{Category.count} categories"
puts "Created #{Product.count} products"
AdminUser.find_or_create_by!(email: "admin@prairietechstore.com") do |admin|
  admin.password = "Admin@12345"
  admin.password_confirmation = "Admin@12345"
end