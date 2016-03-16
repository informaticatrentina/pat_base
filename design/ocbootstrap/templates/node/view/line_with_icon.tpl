<div class="info_block_type_1">
  <div class="icon_wrap_1 f_left r_corners bg_scheme_color t_align_c vc_child color_light tr_all_hover has_tooltip" data-toggle="tooltip" data-placement="top" title="{$node.class_name}"><i class="fa {$node|fa_class_icon( 'fa-circle' )} d_inline_middle"></i></div>
  <h4 class="fw_medium color_dark m_bottom_15"><a href="{$node.url_alias|ezurl(no)}">{$node.name|wash()}</a></h4>
  <p class="f_size_medium m_bottom_10 ">{$node.object.published|datetime( 'custom', '%d %F %Y' )}</p>
  
  <p>{$node|abstract()|oc_shorten(150)}</p>
    
</div>