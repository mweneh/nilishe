module UserTestData

    def user_credentials
      { :username => "helloRutubishi", :email => "app@rutubishi.com", :pass => "Complexity.!123"  }
    end
  
    def invalid_user_credentials
      { :username => "hi", :email => "app", :pass => "123456" }
    end
  
  end