# SimulationView
## schema pattern

* type = "SimulationView"
* particle_count - how many particle objects to simulate
* url, url_script or url_script_list (optional) - yields background image
* layout_width
* layout_height

Based on an early Android code example (ala 2014, sdk v5 "com.example.android.accelerometerplay").

Plans are to add lots more options - a dynamic "free body diagram" for puzzles or games.

Related:
[ImageView](ImageView.md) 

See GitHub Gallery Tab SimulationView.

Example:
```json
{
  "component_list": [
    {
      "layout_height": "match_parent",
      "layout_width": "match_parent",
      "type": "SimulationView",
      "particle_count": "50",
      "url_script": "eigenFragment.getCacheString('RootUrl')+'res/images/wood.jpg'"
    }
  ],
  "gravity": "center_horizontal",
  "layout_height": "match_parent",
  "layout_width": "match_parent",
  "orientation": "vertical",
  "type": "LinearLayout"
}
```
