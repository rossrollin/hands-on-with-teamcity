variable "vpc_id" {}
variable "vpc_subnet_id" {}

variable "instances_to_deploy" {
    default = 3
}

variable "instance_type" {
    default = "t2.medium"
}
variable "key_name" {}
variable "inst_base_name" {
    default = "pg18"
}
variable "ssh_user" {
    default = "playground"
}

variable "ssh_password" {
    default = "PeoplesComputers1"
}

variable "aws_region" {
    default = "eu-west-1"
}
variable "r53_zone_id" {}

variable "animals" {
    default = [
        "Mosquito",
        "Dog",
        "Hyena",
        "Peafowl",
        "Krill",
        "Ant",
        "Vole",
        "Wolf",
        "Mastodon",
        "Armadillo",
        "Marmoset",
        "Loris",
        "Tiglon",
        "Dromedary",
        "Phalangeriformes",
        "Meadowlark",
        "Anteater",
        "Woodpecker",
        "Swordfish",
        "Rhinoceros",
        "Macaw",
        "Xerinae",
        "Carp",
        "Manatee",
        "Porpoise",
        "Crayfish",
        "Vixen",
        "Mite",
        "Voalavoanala",
        "Hare",
        "Chameleon",
        "Aardwolf",
        "Gecko",
        "Weasel",
        "Lynx",
        "Rattlesnake",
        "Spoonbill",
        "Pig",
        "Dove",
        "Salamander",
        "Pigeon",
        "Bat",
        "Coydog",
        "Capybara",
        "Angelfish",
        "Waterbuck",
        "Unicorn",
        "Buffalo",
        "Perch",
        "Snipe",
        "Jackal",
        "Kingfisher",
        "Flyingfish",
        "Skink",
        "Albatross",
        "Ladybug",
        "Dormouse",
        "Ocelot",
        "Egret",
        "Giraffe",
        "Trout",
        "Beetle",
        "Parakeet",
        "Tick",
        "Yak",
        "Yak",
        "Zuniga",

        "Toucan",
        "Liliger",
        "Dragon",
        "Pony",
        "Sloth",
        "Snail",
        "Zarudny",
        "Mackerel",
        "Moth",
        "Sparrow",
        "Coypu",
        "Camel",
        "Puffin",
        "Judah",
        "Gibbon",
        "Zebu",
        "Herring",
        "Tern",
        "Crab",
        "Rajiformes",
        "Crow",
        "Damselfly",
        "Hawk",
        "Gayal",
        "Hamster",
        "Peacock",
        "Shrimp",
        "Panda",
        "Mockingbird",
        "Buzzard",
        "Reindeer",
        "Dodo",
        "Cheetah",
        "Boidae",
        "Raccoon",
        "Antelope",
        "Lionfish",
        "Star",
        "Bobcat",
        "Guineafowl",
        "Jaguar",
        "Echidna",
        "Sturgeon",
        "Grouse",
        "Cattle",
        "Cicada",
        "Louse",
        "Cat",
        "Cat",
        "Baboon",
        "Jagger",
        "Sheep",
        "Zebra",
        "Quokka",
        "Bee",
        "Marsupial",
        "Wildcat",
        "Crawdad",
        "Oribi",
        "Ferret",
        "Clam",
        "Rabbit",
        "Panthera",
        "Titi",
        "Stork",
        "Viperidae",
        "Walrus",
        "Bull",
        "Megabat",
        "Serval",
        "Zenker",
        "Owl",
        "Hoverfly",
        "Parrot",
        "Deer",
        "Ptarmigan",
        "Fish",
        "Flamingo",
        "Dingo",
        "Kangaroo",
        "Boar",
        "Jellyfish",
        "Hinny",
        "Fowl",
        "Earwig",
        "Jagulep",
        "Ermine",
        "Moose",
        "Mammal",
        "Porcupine",
        "Magpie",
        "Shrew",
        "Zebroid",
        "Iguana",
        "Lijagulep",
        "Llama",
        "Goat",
        "Heron",
        "Lipard",
        "Geococcyx",
        "Catshark",
        "Mink",
        "Caterpillar",
        "Finch",
        "Squirrel",
        "Muskox",
        "Shark",
        "Booby",
        "Woodchuck",
        "Koi",
        "Spider",
        "Beaver",
        "Alligator",
        "Whale",
        "Hedgehog",
        "Mollusk",
        "Swift",
        "Slug",
        "Termite",
        "Prawn",
        "Swallow",
        "Hookworm",
        "Caribou",
        "Okapi",
        "Huarizo",
        "Marten",
        "Grebe",
        "Bobolink",
        "Crocodile",
        "Pythonidae",
        "Cougar",
        "Penguin",
        "Numbat",
        "Toad",
        "Bison",
        "Rodent",
        "Bovid",
        "Coyote",
        "Hornet",
        "Opossum",
        "Earthworm",
        "Goose",
        "Bonobo",
        "Tahr",
        "Nightingale",
        "Human",
        "Leopon",
        "Tiliger",
        "Leotig",
        "Snake",
        "Ibis",
        "Tigon",
        "Marmot",
        "Vaquita",
        "Gerbil",
        "Tuna",
        "Mallard",
        "Wombat",
        "Latrodectus",
        "Cephalopod",
        "Mantis",
        "Needlefish",
        "Cuckoo",
        "Grasshopper",
        "Limpet",
        "Swan",
        "Raven",
        "Donkey",
        "Quetzal",
        "Quelea",
        "Warbler",
        "Kiwi",
        "Butterfly",
        "Lamprey",
        "Whippet",
        "Goldfish",
        "Coywolf",
        "Coregonus",
        "Amphibian",
        "Canid",
        "Zempoalt",
        "Takin",
        "Bandicoot",
        "Reptile",
        "Leopard",
        "Planarian",
        "Guanaco",
        "Lemming",
        "Jacana",
        "Dogla",
        "Lapwing",
        "Starfish",
        "Hyrax",
        "Parrotfish",
        "Monkey",
        "Ox",
        "Fox",
        "Horse",
        "Falcon",
        "Scorpion",
        "Chickadee",
        "Dhole",
        "Guppy",
        "Fly",
        "Wren",
        "Marlin",
        "Meerkat",
        "Cockroach",
        "Arthropod",
        "Scallop",
        "Stoat",
        "Pinniped",
        "Lobster",
        "Tarantula",
        "Tarsier",
        "Silkworm",
        "Gorilla",
        "Alpaca",
        "Rooster",
        "Gazelle",
        "Antlion",
        "Eel",
        "Landfowl",
        "Saber",
        "Chimpanzee",
        "Firefly",
        "Liger",
        "Chinchilla",
        "Leoger",
        "Skunk",
        "Dragonfly",
        "Centipede",
        "Wasp",
        "Mandrill",
        "Urial",
        "Anglerfish",
        "Tiger",
        "Maya",
        "Roundworm",
        "Frog",
        "Cobra",
        "Vulture",
        "Emu",
        "Lemur",
        "Mongoose",
        "Olingo",
        "Gull",
        "Hippopotamus",
        "Pelican",
        "Elephant",
        "Bear",
        "Halibut",
        "Condor",
        "Mule",
        "Mouse",
        "Lungfish",
        "Galliform",
        "Minnow",
        "Wolfdog",
        "Wolverine",
        "Zaphir",
        "Turtle",
        "Narwhal",
        "Ostrich",
        "Octopus",
        "Catfish",
        "Tortoise",
        "Wallaby",
        "Tiguar",
        "Stingray",
        "Locust",
        "Salmon",
        "Nighthawk",
        "Lark",
        "Duck",
        "Tapir",
        "Dinosaur",
        "Hummingbird",
        "Marozi",
        "Lion",
        "Silverfish",
        "Orangutan",
        "Flea",
        "Dolphin",
        "Jaglion",
        "Anaconda",
        "Loon",
        "Rook",
        "Piranha",
        "Wildebeest",
        "Clownfish",
        "Aphid",
        "Vicu",
        "Bedbug",
        "Squid",
        "Jay",
        "Cod",
        "Barnacle",
        "Sialia",
        "Haddock",
        "Rat",
        "Sawfish",
        "Batoidea",
        "Bird",
        "Barracuda",
        "Chipmunk",
        "Newt",
        "Otter",
        "Eagle",
        "Platypus",
        "Orca",
        "Chicken",
        "Ape",
        "Pheasant",
        "Lizard",
        "Leech",
        "Axolotl",
        "Quail",
        "Leguar",
        "Litigon",
        "Sailfish",
        "Coral",
        "Wildfowl",
        "Gamefowl",
        "Partridge",
        "Worm",
        "Koala",
        "Primate"
    ]
}