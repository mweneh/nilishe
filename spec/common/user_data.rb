module UserTestData

    def user_credentials
      { :username => "helloRutubishi", :email => "app@rutubishi.com", :pass => "Complexity.!123"  }
    end
  
    def invalid_user_credentials
      { :username => "hi", :email => "app", :pass => "123456" }
    end
  
    def dummy_user
      User.create(username: user_credentials[:username], 
                  email: user_credentials[:email], password: user_credentials[:pass])
    end
  end