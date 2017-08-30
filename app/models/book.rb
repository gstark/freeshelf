class Book < ApplicationRecord
  # This tells active record to expect the `books` table
  # (the one that this model represents) to have a column
  # called `user_id` that is an integer (and a foreign key)
  # to the `users` table
  belongs_to :user
end
