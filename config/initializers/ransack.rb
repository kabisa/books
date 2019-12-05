Ransack.configure do |c|
  class_name = 'sort-indicator'
  done_icon = "<i class='material-icons #{class_name}'>done</i>"
  just_a_span = "<span class='#{class_name}'/>"

  c.custom_arrows = {
    up_arrow: done_icon,
    down_arrow: done_icon,
    default_arrow: just_a_span
  }
end
