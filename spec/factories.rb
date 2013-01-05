FactoryGirl.define do
	factory :user do
		name		"Thomas Chung"
		email		"chungty@gmail.com"
		password	"foobar"
		password_confirmation	"foobar"
	end
end