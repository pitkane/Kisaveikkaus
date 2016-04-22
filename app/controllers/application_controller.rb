# encoding: UTF-8

class ApplicationController < ActionController::Base
  
  helper_method :get_series
  helper_method :get_countries


  def get_series(serie)
    if serie == 1
      return "Miehet"
    elsif serie == 2
      return "Naiset"
    else
      return "Yhteinen"
    end
  end

  def get_countries
    text = '["Afganistan", "Albania", "Algeria", "Amerikan Samoa", "Andorra", "Angola", "Antigua ja Barbuda", "Argentiina", "Armenia", "Australia", "Itävalta", "Azerbaidzan", "Bahama", "Bahrain", "Barbados", "Valko-Venäjä", "Belgia", "Bermuda", "Bolivia", "Bosnia ja Hertsegovina", "Botswana", "Brasilia", "Brittiläiset Neitsytsaaret", "Bulgaria", "Burundi", "Kamerun", "Kanada", "Caymansaaret", "Keski-Afrikan tasavalta", "Chile", "Kiina", "Kolumbia", "Kongo", "Cookinsaaret", "Costa Rica", "Norsunluurannikko", "Kroatia", "Kuuba", "Kypros", "Tsekki", "Tanska", "Djibouti", "Dominica", "Dominikaaninen tasavalta", "Ecuador", "Egypti", "El Salvador", "Eritrea", "Viro", "Etiopia", "Fidzi", "Suomi", "Ranska", "Gabon", "Georgia", "Saksa", "Ghana", "Iso-Britannia", "Kreikka", "Grenada", "Guatemala", "Guinea-Bissau", "Guyana", "Haiti", "Honduras", "Hongkong", "Unkari", "Islanti", "Intia", "Indonesia", "Iran", "Irlanti", "Israel", "Italia", "Jamaika", "Japani", "Jordania", "Kazakstan", "Kenia", "Pohjois-Korea", "Etelä-Korea", "Kuwait", "Kirgisia", "Latvia", "Libanon", "Liberia", "Libya", "Liettua", "Luxemburg", "Madagaskar", "Malesia", "Malta", "Meksiko", "Moldova", "Mongolia", "Montenegro", "Marokko", "Mosambik", "Namibia", "Hollanti", "Uusi-Seelanti", "Nigeria", "Norja", "Oman", "Pakistan", "Panama", "Papua-Uusi-Guinea", "Paraguay", "Peru", "Filippiinit", "Puola", "Portugali", "Puerto Rico", "Qatar", "Romania", "Venäjä", "Ruanda", "Saint Kitts ja Nevis", "Saint Lucia", "Samoa", "San Marino", "Saudi-Arabia", "Senegal", "Serbia", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Etelä-Afrikka", "Espanja", "Sudan", "Ruotsi", "Sveitsi", "Syyria", "Kiinan Taipei", "Tadzikistan", "Tansania", "Thaimaa", "Trinidad ja Tobago", "Tunisia", "Turkki", "Turkmenistan", "Uganda", "Ukraina", "Yhdistyneet arabiemiirikunnat", "Yhdysvallat", "Uruguay", "Uzbekistan", "Venezuela", "Vietnam", "Neitsytsaaret", "Sambia", "Zimbabwe"]'
    return text
  end


  protect_from_forgery
end
