{if $root_node|has_attribute('logo')}
    
    <div class="top-bar">
        <img src='/extension/pat_base/design/itbase_v3/images/top-bar.png'>
    </div>
    <div class="top-bar-small">
        <img src='/extension/pat_base/design/itbase_v3/images/top-bar-small.png'>
    </div>
    
    <div class="tob-bar-icons">
        <div class="row">
            <div class ="top-social-icons col-xs-offset-2 col-xs-3">
                {* SOCIAL *}
                {def $contacts = footer('footer_contacts')}
                
                {if is_set($contacts.facebook)}
                    <a class="social-icon" href={$contacts.facebook}>
                        <span class="fa-stack">
                            <i class="fa fa-circle fa-stack-1x fa-inverse social-circle"></i>
                            <i class="fa fa-facebook fa-stack-1x social-logo"></i>
                        </span>
                    </a>
                </li>
                {/if}
                
                {if is_set($contacts.twitter)}
                    <a class="social-icon" href={$contacts.twitter}>
                        <span class="fa-stack">
                            <i class="fa fa-circle fa-stack-1x fa-inverse social-circle"></i>
                            <i class="fa fa-twitter fa-stack-1x social-logo"></i>
                        </span>
                    </a>
                </li>
                {/if}
                
                {if is_set($contacts.youtube)}
                    <a class="social-icon" href={$contacts.youtube}>
                        <span class="fa-stack">
                            <i class="fa fa-circle fa-stack-1x fa-inverse social-circle"></i>
                            <i class="fa fa-youtube fa-stack-1x social-logo"></i>
                        </span>
                    </a>
                </li>
                {/if}
                
                {undef $contacts}
            </div>
            <div class="col-xs-2">
                <div class="row site-logo">
                    <div class="col-xs-offset-3 col-xs-6 text-center">
                        <a href="http://www.provincia.tn.it" title="Provincia Autonoma di Trento">
                            {if $root_node|attribute('logo').content.original.url}
                                <img src={$root_node|attribute('logo').content.original.url|ezroot()} 
                                     alt="{$root_node.name}" />
                            {/if}
                        </a>
                    </div>
                </div>
                {if $root_node|has_attribute('logo_mobile')}
                <div class="row site-logo-small">
                    <div class="col-xs-offset-3 col-xs-5 text-center">
                        <a href="http://www.provincia.tn.it" title="Provincia Autonoma di Trento">
                            {if $root_node|attribute('logo_mobile').content.original.url}
                                <img src={$root_node|attribute('logo_mobile').content.original.url|ezroot()} 
                                     alt="{$root_node.name}" />
                            {/if}
                        </a>
                    </div>
                </div>    
                {/if}
            </div>
            <div class="col-xs-offset-2 col-xs-3">
                {* BANNER *}
                                               
                {def $banners = fetch( 'content', 'list', hash( 'parent_node_id', 2,
                                                                'attribute_filter', array('and',array('priority','>=','3000'),array('priority','<','4000')) ) )}
                
                {foreach $banners as $banner}
                    {attribute_view_gui attribute=$banner|attribute('image') href=$banner|attribute('url').content|ezurl image_class='banner_top'}
                {/foreach}
                {undef $banners}
            </div>
        </div>
    </div>
{/if}
