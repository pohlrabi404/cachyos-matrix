read width height <<< $(swaymsg -t get_tree | jq '.. | select(.type? == "root") | .rect | "\(.width) \(.height)"' | tr -d '"')

nheight=$(awk "BEGIN {print $height * 1}")
nwidth=$(awk "BEGIN {print $width * 1}")

swaymsg for_window [app_id="mpv"] move absolute position $(($nwidth-576-40)) px $(($nheight-324-40)) px

swaymsg focus tiling
