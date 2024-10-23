read width height <<< $(swaymsg -t get_tree | jq '.. | select(.type? == "root") | .rect | "\(.width) \(.height)"' | tr -d '"')

swaymsg for_window [app_id="mpv"] move absolute position $(($width-576-40)) px $(($height-324-40)) px

swaymsg focus tiling
