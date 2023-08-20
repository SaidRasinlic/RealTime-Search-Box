# Pin npm packages by running ./bin/importmap

pin "application", preload: true
# pin 'chart', to: 'node_modules/chart.js/dist/chart.min.js'
# config/importmap.rb
pin "chartkick", to: "chartkick.js"
pin "Chart.bundle", to: "Chart.bundle.js"
pin '@fortawesome/fontawesome-free', to: 'https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.1.1/js/all.js'
pin "@rails/actioncable", to: "actioncable.esm.js"
pin_all_from "app/javascript/channels", under: "channels"
