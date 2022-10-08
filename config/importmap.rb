# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.2.2/dist/js/bootstrap.esm.js"
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.6/lib/index.js"
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.6.1/dist/jquery.js"
pin "common", to: "common.js"

Dir.glob(Rails.application.root.to_s + '/app/javascript/custom/*').map { |f| File.basename(f).split('.').first }.each do |filename|
  pin filename, to: "custom/#{filename}.js"
end