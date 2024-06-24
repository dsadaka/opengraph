class Url < ApplicationRecord

  after_create_commit -> { broadcast_prepend_to "urls", partial: "urls/url", locals: { url: self }, target: "urls" }

end
