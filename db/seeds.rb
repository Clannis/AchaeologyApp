require_relative '../config/environment'

user1 = User.create(username: "prof1", email: "prof1@uni.edu", password: "password", name: "ralf-sanchez")
user2 = User.create(username: "stud1", email: "stud1@uni.edu", password: "password", name: "maria-smith")
user3 = User.create(username: "prof2", email: "prof2@uni.edu", password: "password", name: "alex-daniels")

dig_site1 = DigSite.create(name: "0001", location: "spain", user_id: user1.id)
dig_site2 = DigSite.create(name: "0002", location: "rome", user_id: user3.id)

unit1 = Unit.create(local_id: "01", size: "1x1 meter", dig_site_id: dig_site1.id)
unit2 = Unit.create(local_id: "01", size: "1x1 meter", dig_site_id: dig_site2.id)
unit3 = Unit.create(local_id: "02", size: "1x1 meter", dig_site_id: dig_site1.id)
unit4 = Unit.create(local_id: "02", size: "1x1 meter", dig_site_id: dig_site2.id)

level1 = Level.create(local_id: "01", beg_depth: "0cm", end_depth: "10cm", unit_id: unit1.id)
level2 = Level.create(local_id: "02", beg_depth: "10cm", end_depth: "20cm", unit_id: unit1.id)
level3 = Level.create(local_id: "01", beg_depth: "0cm", end_depth: "10cm", unit_id: unit2.id)
level4 = Level.create(local_id: "02", beg_depth: "10cm", end_depth: "20cm", unit_id: unit2.id)
level5 = Level.create(local_id: "01", beg_depth: "0cm", end_depth: "10cm", unit_id: unit3.id)
level6 = Level.create(local_id: "02", beg_depth: "10cm", end_depth: "20cm", unit_id: unit3.id)
level7 = Level.create(local_id: "01", beg_depth: "0cm", end_depth: "10cm", unit_id: unit4.id)
level8 = Level.create(local_id: "02", beg_depth: "10cm", end_depth: "20cm", unit_id: unit4.id)

artifact1 = Artifact.create(local_id: "K-01", artifact_type: "knife", description: "knife made out of flint rock", level_id: level1.id)
artifact2 = Artifact.create(local_id: "P-01", artifact_type: "bowl", description: "pottery bowl", level_id: level2.id)
artifact2 = Artifact.create(local_id: "J-01", artifact_type: "ring", description: "golden ring", level_id: level3.id)
artifact4 = Artifact.create(local_id: "M-01", artifact_type: "sherd", description: "pottery sherd", level_id: level4.id)
artifact5 = Artifact.create(local_id: "M-02", artifact_type: "glass", description: "piece of glass", level_id: level5.id)
artifact6 = Artifact.create(local_id: "U-01", artifact_type: "pipe", description: "corncob pipe", level_id: level6.id)
artifact7 = Artifact.create(local_id: "M-03", artifact_type: "shard", description: "pottery shard", level_id: level8.id)
artifact8 = Artifact.create(local_id: "B-01", artifact_type: "bone", description: "mandible", level_id: level1.id)