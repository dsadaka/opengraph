class Url < ApplicationRecord

  after_create_commit -> { broadcast_prepend_to "quotes", partial: "urls/url", locals: { url: self }, target: "urls" }

end
