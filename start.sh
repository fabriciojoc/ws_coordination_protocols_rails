cd store-system
rails s &
cd ..
cd provider
rails s -p 3001 &
cd ..
cd bank
rails s -p 3002 &
cd ..
cd coordinator
rails s -p 3003 &