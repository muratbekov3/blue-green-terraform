project_id   = "muratbekuulu-gc-bootcamp1"
region       = "europe-west3"
zone         = "europe-west3-a"
name_prefix  = "cmtr-f1u79s6m"
machine_type = "e2-medium"
image        = "debian-cloud/debian-12"

vpc_name    = "cmtr-f1u79s6m-vpc"
subnet_name = "cmtr-f1u79s6m-public-subnet"

owner = "akylbek_muratbekuulu"

blue_weight  = 100
green_weight = 0