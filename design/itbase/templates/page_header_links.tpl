<div class="row">
    <div class="col-md-9 col-sm-7 col-xs-4">
        <ul class="list-inline text-center pull-right">
            <li id="newsletter">
                <a href="{'/ptn/newsletter'|ezurl(no)}" 
                   data-toggle-tt="tooltip" 
                   data-placement="bottom" 
                   title="Newsletter">
                     <i class="fa fa-envelope"></i>
                 </a>
            </li>

            {if $current_user.is_logged_in}
            {if fetch( 'user', 'has_access_to', hash( 'module', 'content', 'function', 'dashboard' ))}
              <li id="dashboard">
                  <a href={"/content/dashboard/"|ezurl} 
                     title="{'Dashboard'|i18n('design/admin/content/dashboard')}" 
                     data-toggle-tt="tooltip" 
                     data-placement="bottom" 
                     title="Dashboard">
                        <i class="fa fa-tachometer"></i>
                  </a>
              </li>
            {/if}
            <li id="myprofile">
                <a href={"/user/edit/"|ezurl} 
                   title="{'My profile'|i18n('design/ocbootstrap/pagelayout')}"
                   data-toggle-tt="tooltip" 
                   data-placement="bottom" 
                   title="{'My profile'|i18n('design/ocbootstrap/pagelayout')}">
                    <i class="fa fa-user"></i>
                </a>
            </li>
            <li id="logout">
                <a href={"/user/logout"|ezurl}
                   title="{'Logout'|i18n('design/ocbootstrap/pagelayout')}"
                   data-toggle-tt="tooltip" 
                   data-placement="bottom" 
                   title="{'Logout'|i18n('design/ocbootstrap/pagelayout')}">
                    <i class="fa fa-sign-out"></i>
                </a>
            </li>
          {else}
            {if ezmodule( 'user/register' )}
                <li id="registeruser">
                    <a href={"/user/register"|ezurl} 
                       title="{'Register'|i18n('design/ocbootstrap/pagelayout')}"
                       data-toggle-tt="tooltip" 
                       data-placement="bottom" 
                       title="{'Register'|i18n('design/ocbootstrap/pagelayout')}">
                        <i class="fa fa-user"></i>
                    </a>
                </li>
            {/if}
            <li id="login" class="dropdown">
                <a href="#" 
                   class="dropdown-toggle" 
                   data-toggle="dropdown" 
                   data-toggle-tt="tooltip" 
                   data-placement="bottom" 
                   title="{'Login'|i18n('design/ocbootstrap/pagelayout')}">
                    <i class="fa fa-sign-in"></i>
                </a>
              <div class="panel dropdown-menu dropdown-menu-right login-menu">
                <form class="login-form" action="{'/user/login'|ezurl( 'no' )}" method="post">
                  <fieldset>
                    <div class="form-group">
                      <label for="login-username" class="sr-only">{'Username'|i18n('design/ocbootstrap/pagelayout')}</label>
                      <input class="form-control" type="text" name="Login" id="login-username" placeholder="Username">
                    </div>
                    <div class="form-group">
                      <label for="login-password" class="sr-only">{'Password'|i18n('design/ocbootstrap/pagelayout')}</label>
                      <input class="form-control" type="password" name="Password" id="login-password" placeholder="Password">
                    </div>
                    <button class="btn btn-primary pull-right" type="submit">
                          {'Login'|i18n('design/ocbootstrap/pagelayout')}
                      </button>
                      <p class="small">
                          <a href="{'/user/forgotpassword'|ezurl( 'no' )}" class="forgot-password">
                              {'Forgot your password?'|i18n('design/ocbootstrap/pagelayout')}
                          </a>
                      </p>
                  </fieldset>
                  <input type="hidden" name="RedirectURI" value="" />
                </form>
              </div>
            </li>
        {/if}
        </ul>
    </div>
    <div class="col-md-3 col-sm-5 col-xs-8">
        {include uri='design:page_header_searchbox.tpl'}
    </div>
</div>