
<div class="row">
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-5">
              
                {def $curMonth = currentdate()|datetime( 'custom', '%m' )}
                {def $curYear = currentdate()|datetime( 'custom', '%Y' )}                        
                {def $curStrMonth = currentdate()|datetime( 'custom', '%F' )}
                       
                <input type="hidden" id="currentSelectedMonth" value="{currentdate()|datetime( 'custom', '%Y-%m-01' )}">
                <ul class="pagination">
                    <li><a href="" id="calendardPrexMonth"><span class="text"><< Precedente</span></a></li>
                    <li class="active"><span class="text" id="calendardCorrentMonth">Mese di {$curStrMonth} {$curYear}</span></a></li>
                    <li><a href="" id="calendardNextMonth"><span class="text">Successivo >></span></a></li>
                </ul>               
            </div>
            <div class="form-group col-md-3" style="margin: 20px 0; ">

               
            </div>
            <div class="col-md-3">
                {* Search *}
                <div class="input-group" style="margin: 20px 0; ">
                <div class="input-group-addon">
                    <i class="fa fa-search"></i>
                    </div>                
                    <input class="form-control"  type="text"
                        id="query" 
                        name="query"
                        placeholder="Filtra ...">
                </div>
            </div>    
                <div class="col-md-1" style="margin: 25px 0; ">
                    <a id="prv_reset_button" class="pull-right" style="display: none; cursor: pointer;">
                    Azzera </a>
                </div>
        </div>                                            
     
                    
        {* PANNELLI *}                    
        <div id="cur-calendar" name="cur-calendar" class="cur-calendar row">
            <div id="prv_loading" class="col_md-12 text-center" style="padding-top: 100px ; padding-bottom: 100px">
                <i class="fa fa-spinner fa-spin fa-3x"></i>
            </div>
        </div>
    </div>

    {include uri="design:parts/event_calendar/event_calendar_script.tpl"}

</div>
