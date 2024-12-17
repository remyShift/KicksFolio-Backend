namespace :tokens do
  desc "Clean expired invalid tokens"
  task cleanup: :environment do
    InvalidToken.where('exp < ?', Time.now).delete_all
  end
end 