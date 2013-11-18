# Se debe colocar el container en DWF (Dallas) la gema de FOG solo busca en Dallas y no en los demás
connection = Fog::Storage.new({
       :provider           => 'Rackspace',
       :rackspace_username => 'okgarces',
       :rackspace_api_key  => 'b3468152f631ab0d9427c25efdb76915'
     })