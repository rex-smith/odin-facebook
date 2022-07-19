module ApplicationHelper
  def avatar_thumbnail_sm(user)
    if user.avatar.attached?
      image_tag(user.avatar.variant(resize_to_fill: [40, 40], gravity: 'Center'), class: "rounded")
    end
  end

  def avatar_thumbnail_med(user)
    if user.avatar.attached?
      image_tag(user.avatar.variant(resize_to_fill: [80, 80, { gravity: 'Center' }]), class: "rounded")
    end
  end

  def avatar_thumbnail_lg(user)
    if user.avatar.attached?
      image_tag(user.avatar.variant(resize_to_fill: [160, 160]), class: "rounded border")
    end
  end

  def avatar(user)
    if user.avatar.attached?
      image_tag(user.avatar, class: "rounded border")
    end
  end
end
