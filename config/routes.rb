Retweeter::Application.routes.draw do
  root :to => 'static#home'
  match ":action"  => 'static#:action'
end
