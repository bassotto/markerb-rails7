require "action_view"
require "action_view/template"
require "markerb/markdown"
require "markerb/railtie"

module Markerb
  class Handler
    def erb_handler
      @erb_handler ||= ActionView::Template.registered_template_handler(:erb)
    end

    def call(template, src)
      compiled_source = erb_handler.call(template, src)
      "Markerb::Markdown.to_html(begin;#{compiled_source};end).html_safe"
    end
  end
end

ActionView::Template.register_template_handler :markerb, Markerb::Handler.new
