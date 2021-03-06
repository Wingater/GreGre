package kh.mclass.Igre.common;

public class Pagebar {
	
	public static String getPageBar(int totalContents, int cPage, int numPerPage, String url) {
        
		String pageBar="";
        int pageBarSize=5;
        
        int pageNo = ((cPage-1)/pageBarSize)*pageBarSize+1;
        int pageEnd = pageNo+pageBarSize-1;
        int totalPage = (int)Math.ceil((double)totalContents/numPerPage);
        
        //이전 버튼
        pageBar = "<ul class='pagination justify-content-center pagination-sm'>";
        if(pageNo==1)
        {
            pageBar += "<li class='page-item' disabled>";
            pageBar += "<a class='page-link' href='#' tabindex='-1'>이전</a>";
            pageBar += "</li>";
        }else {
            pageBar += "<li class='page-item'>";
            pageBar += "<a class='page-link' href='javascript:fn_paging("+(pageNo-1)+")'>이전</a>";
            pageBar += "</li>";
        }
        
        //1~5 숫자
        while(!(pageNo>pageEnd || pageNo>totalPage)) {
            if(pageNo==cPage) {
                pageBar += "<li class='page-item' active>";
                pageBar += "<a class='page-link'>"+pageNo+"</a>";
                pageBar += "</li>";
            }else {
                pageBar += "<li class='page-item'>";
                pageBar += "<a class='page-link' href='javascript:fn_paging("+(pageNo)+")'>"+pageNo+"</a>";
                pageBar += "</li>";
            }
            pageNo++;
        }
        
        //다음 버튼
        if(pageNo>totalPage)
        {
            pageBar += "<li class='page-item' disabled>";
            pageBar += "<a class='page-link' href='#'>다음</a>";
            pageBar += "</li>";
        }else {
            pageBar += "<li class='page-item'>";
            pageBar += "<a class='page-link' href='javascript:fn_paging("+(pageNo)+")'>다음</a>";
            pageBar += "</li>";
        }
        pageBar +="</ul>";
        
        //paging 처리 script 작성
        pageBar +="<script>";
        pageBar +="function fn_paging(cPage){";
        pageBar +="location.href='"+url+"&cPage='+cPage";
        pageBar +="}";
        pageBar +="</script>";
        
        return pageBar;
    }

}