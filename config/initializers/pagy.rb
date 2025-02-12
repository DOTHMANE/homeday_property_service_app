require 'pagy/extras/overflow'
require 'pagy/extras/metadata'
# Optionally override some pagy default with your own in the pagy initializer
Pagy::DEFAULT[:limit] = 50 # items per page
# Better user experience handled automatically
Pagy::DEFAULT[:overflow] = :last_page