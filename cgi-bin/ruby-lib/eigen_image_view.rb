class EigenFrame

  def eigen_image_view(url_script_list)
    {
      type: "ImageView",
      url_script_list: url_script_list,
      layout_width: "100",
      layout_height: "100",
      on_click:
        {
          type: "JavaScript",
          script: "eigenActivity.showToast('image clicked')"
        }
    }
  end

end