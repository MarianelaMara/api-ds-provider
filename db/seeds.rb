User.create(user_name: "bonita", email: "bonita@mail.com", password: "123123")

Material.create(name: "pino")
Material.create(name: "roble")
Material.create(name: "cedro")
Material.create(name: "nogal")
Material.create(name: "caoba")
Material.create(name: "aluminio")
Material.create(name: "acero inoxidable")
Material.create(name: "laton")
Material.create(name: "policarbonato")
Material.create(name: "polipropileno")
Material.create(name: "poliuretano")
Material.create(name: "vidrio")

Provider.create(name: "Maderas S.A.", country: "Argentina", address: "Av. San Martín 1234", city: "City Bell")
Provider.create(name: "Metales S.R.L.", country: "Argentina", address: "Calle 25 de Mayo 5678", city: "La Plata")
Provider.create(name: "Plásticos S.A.", country: "Argentina", address: "Ruta 2 Km. 35", city: "Berazategui")
Provider.create(name: "ENVITAP S.A.", country: "Argentina", address: "Av. San Martín 1234", city: "City Bell")
Provider.create(name: "Blue Sky SA", country: "Argentina", address: "Calle 25 de Mayo 5678", city: "Mendoza")
Provider.create(name: "Cristal Center", country: "Argentina", address: "Ruta 2 Km. 35", city: "Berazategui")
Provider.create(name: "Woodex", country: "Canadá", address: "100 Main Street", city: "Toronto")
Provider.create(name: "Metalix", country: "China", address: "No. 8 Huaxia Road", city: "Shanghai")
Provider.create(name: "Plastix", country: "Brasil", address: "Rua das Flores, 123", city: "São Paulo")


Maker.create(name: "Muebles S.A.", country: "Argentina", address: "Av. San Martín 1234", city: "City Bell", price: 100.0)
Maker.create(name: "Glassy", country: "España", address: "Calle Mayor 5678", city: "Madrid", price:400.0 )
Maker.create(name: "Mparts S.R.L.", country: "Argentina", address: "Calle 25 de Mayo 5678", city: "La Plata", price:400.0 )
Maker.create(name: "Elrix", country: "China", address: "No. 8 Huaxia Road", city: "Shanghai",price:400.0 )
Maker.create(name: "Ccos S.A.", country: "Argentina", address: "Av. San Martín 1234", city: "City Bell", price:600.0 )
Maker.create(name: "Tand", country: "Estados Unidos", address: "100 Main Street", city: "New York", price:500.0 )
Maker.create(name: "Bic S.R.L.", country: "Argentina", address: "Calle 25 de Mayo 5678", city: "La Plata", price:400.0 )
Maker.create(name: "Trix", country: "China", address: "No. 8 Huaxia Road", city: "Shanghai", price:400.0 )
Maker.create(name: "Vid S.A.", country: "Argentina", address: "Ruta 2 Km. 35", city: "Berazategui", price:800.0 )
Maker.create(name: "Jewelix", country: "Italia", address: "Via Roma 1234", city: "Roma", price:900.0 )


# Ejemplo 1: Crear una provision de madera de pino por 100 pesos el metro cúbico, con 50 unidades en stock y 10 días de entrega
Provision.create(provider_id: 1, material_id: 1, price: 100.0, stock: 50, delivery_time: 10)
# Ejemplo 2: Crear una provision de aluminio por 200 pesos el kilogramo, con 100 unidades en stock y 15 días de entrega
Provision.create(provider_id: 6, material_id: 6, price: 200.0, stock: 100, delivery_time: 15)
# Ejemplo 3: Crear una provision de vidrio por 300 pesos el metro cuadrado, con 25 unidades en stock y 20 días de entrega
Provision.create(provider_id: 12, material_id: 12, price: 300.0, stock: 25, delivery_time: 20)
# Ejemplo 4: Crear una provision de roble por 150 pesos el metro cúbico, con 40 unidades en stock y 12 días de entrega
Provision.create(provider_id: 2, material_id: 2, price: 150.0, stock: 40, delivery_time: 12)
# Ejemplo 5: Crear una provision de acero inoxidable por 250 pesos el kilogramo, con 80 unidades en stock y 18 días de entrega
Provision.create(provider_id: 7, material_id: 7, price: 250.0, stock: 80, delivery_time: 18)
# Ejemplo 6: Crear una provision de policarbonato por 350 pesos el metro cuadrado, con 30 unidades en stock y 25 días de entrega
Provision.create(provider_id: 9, material_id: 9, price: 350.0, stock: 30, delivery_time: 25)
# Ejemplo 7: Crear una provision de cedro por 120 pesos el metro cúbico, con 60 unidades en stock y 8 días de entrega
Provision.create(provider_id: 3, material_id: 3, price: 120.0, stock: 60, delivery_time: 8)
# Ejemplo 8: Crear una provision de latón por 300 pesos el kilogramo, con 50 unidades en stock y 20 días de entrega
Provision.create(provider_id: 8, material_id: 8, price: 300.0, stock: 50, delivery_time: 20)
# Ejemplo 9: Crear una provision de polipropileno por 400 pesos el metro cuadrado, con 20 unidades en stock y 30 días de entrega
Provision.create(provider_id: 10, material_id:10 , price:400.0 , stock:20 , delivery_time:30 )
# Ejemplo 10: Crear una provision de nogal por 180 pesos el metro cúbico, con 35 unidades en stock y 15 días de entrega
Provision.create(provider_id:4 , material_id:4 , price:180.0 , stock:35 , delivery_time:15 )
# Ejemplo 11: Crear una provision de poliuretano por450 pesos el metro cuadrado, con15 unidades en stock y35 días de entrega
Provision.create(provider_id: 11 , material_id: 11 , price: 450.0 , stock: 15 , delivery_time: 35 )
# Ejemplo12 : Crear una provision de caoba por200 pesos el metro cúbico, con45 unidades en stock y10 días de entrega
Provision.create(provider_id:5 , material_id: 5 , price: 200.0 , stock: 45 , delivery_time: 10 )
# Ejemplo13 : Crear una provision de vidrio por500 pesos el metro cuadrado, con10 unidades en stock y40 días de entrega
Provision.create(provider_id: 13 , material_id: 13 , price: 500.0 , stock: 10 , delivery_time: 40 )



