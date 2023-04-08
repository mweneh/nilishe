module RoutesTestData

    ## ROUTES
    # authentication routes
    def r_auth
      %w[/auth/create_account /auth/login]
    end
  
    # recipe routes
    def r_recipe(rid: 0)
      %W[/recipe/create /recipe/update/#{rid} /recipe/delete/#{rid}]
    end
  
    ## OTHER DATA
    # define headers required when making requests
    def headers
     { 'ACCEPT' => "application/json" }
    end
  
    # add authentication token to headers
    def headers_with_token(token)
      tmp_headers = headers
      tmp_headers['Authorization'] = "Bearer #{token}"
      tmp_headers
    end
  
  
  end