// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "bootstrap";

// Import Rails UJS to handle DELETE method in link_to
import Rails from "@rails/ujs";
Rails.start();
//= require rails-ujs

