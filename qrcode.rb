require 'rqrcode'

def qrcode(url)
  simple_qrcode = RQRCode::QRCode.new(url, level: :l)
  simple_qrcode.as_svg(
    fill: :white,
    color: :black,
    module_size: 11,
    shape_rendering: 'crispEdges',
    use_path: true
  )
end
