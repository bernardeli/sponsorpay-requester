module Helpers
  def title(offer)
    offer['title']
  end

  def payout(offer)
    offer['payout']
  end

  def lowres(offer)
    offer['thumbnail']['lowres']
  end

  def partial(template, *args)
    template_array = template.to_s.split('/')
    template = template_array[0..-2].join('/') + "/_#{template_array[-1]}"
    options = args.last.is_a?(Hash) ? args.pop : {}
    options.merge!(:layout => false) unless options[:layout]
    locals = options[:locals] || {}

    if collection = options.delete(:collection)
      buffer = collection.inject([]) do |arr, member|
        arr << erb(:"#{template}", options.merge(:layout =>
        false, :locals => {template_array[-1].to_sym => member}.merge(locals)))
      end

      erb(buffer.join("\n"), options)
    else
      erb(:"#{template}", options)
    end
  end
end
