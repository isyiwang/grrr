sf_zoo = Zoo.create(name: 'San Francisco Zoo')
sd_zoo = Zoo.create(name: 'San Diego Zoo')

Animal.create(name: 'Curious George', species: 'macaca mulatta', gender: 'male', zoo: sf_zoo)
Animal.create(name: 'Apathetic Greg', species: 'saimiri sciureus', gender: 'male', zoo: sf_zoo)
Animal.create(name: 'Indifferent Iris', species: 'callimico goeldii', gender: 'female', zoo: sf_zoo)
Animal.create(name: 'Larry the Lion', species: 'panthera leo', gender: 'male', zoo: sf_zoo)
Animal.create(name: 'Linda the Lioness', species: 'panthera leo', gender: 'female', zoo: sf_zoo)

Animal.create(name: 'Elsa the Elephant', species: 'loxodonta africana', gender: 'female', zoo: sd_zoo)
Animal.create(name: 'Ed the Elephant', species: 'elephas maximus indicus', gender: 'male', zoo: sd_zoo)
Animal.create(name: 'Paul the Peregrine', species: 'falco peregrinus', gender: 'male', zoo: sd_zoo)
