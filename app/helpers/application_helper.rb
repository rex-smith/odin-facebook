module ApplicationHelper
  def avatar_thumbnail_sm(user)
    if user.avatar.attached?
      image_tag(user.avatar.variant(resize_to_fill: [20, 20]), class: "rounded img-thumbnail")
    end
  end

  def avatar_thumbnail_med(user)
    if user.avatar.attached?
      image_tag(user.avatar.variant(resize_to_fill: [50, 50]), class: "rounded img-thumbnail")
    end
  end

  def avatar_thumbnail_lg(user)
    if user.avatar.attached?
      image_tag(user.avatar.variant(resize_to_fill: [120, 120]), class: "rounded img-thumbnail")
    end
  end

  def avatar(user)
    if user.avatar.attached?
      image_tag user.avatar.variant(resize_to_fill: [200, 200]), class: "rounded img-thumbnail"
    end
  end

  def photo_post_size(photo)
    image_tag photo.variant(resize_to_fill: [400, 400]), class: "rounded img-fluid d-block mx-auto"
  end
end
