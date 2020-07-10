require_relative 'config/environment'

app = Cli.new
app.welcome
case app.create_or_sign_in
when 'Build new profile'
  app.new_member
  app.navigate_member_menu
when 'Sign in'
  app.sign_in
  app.navigate_member_menu
when 'Exit GitFit'
  app.end_app
end
