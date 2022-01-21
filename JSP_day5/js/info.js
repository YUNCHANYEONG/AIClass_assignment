function sendit(){
    /*
        만약에 입력한 값이 있다면 return false;
    */

    const userpw = document.getElementById('userpw');
    const userpw_re = document.getElementById('userpw_re');
    const name = document.getElementById('name');
    const hp = document.getElementById('hp');
    const email = document.getElementById('email');
    const hobby = document.getElementsByName('hobby');


    // 정규식
    const expNameText = /[가-힣]+$/; // + : 뒤로 계속(몇글자일지 모름), $ : 끝, [] : 들어갈 수 있는 문자범위
    const expHpText = /^\d{3}-\d{3,4}-\d{4}$/; 
    // ^ : 이것으로 무조건시작, \d : 숫자, {3,4} : 3글자 혹은 4글자, {} : 글자수
    const expEmailText = /^[A-Za-z0-9\-\.]+@[A-Za-z0-9\-\.]+\.[A-Za-z0-9]+$/;


    if(userpw.value == ''){
        alert('비밀번호를 입력하세요');
        userpw.focus(); // pw 쪽으로 포커스
        return false;
    }
    if(userpw.value.length < 4 || userpw.value.length > 20){
        alert('비밀번호는 4자 이상 20자 이하로 입력하세요');
        userpw.focus(); // pw 쪽으로 포커스
        return false;
    }

    if(userpw.value != userpw_re.value){
        alert('비밀번호와 비밀번호 확인의 값이 다릅니다');
        userpw.focus(); // pw 쪽으로 포커스
        return false;
    }

    if(!expNameText.test(name.value)){
        alert('이름 형식을 확인하세요\n한글만 입력 가능합니다');
        name.focus(); // pw 쪽으로 포커스
        return false;
    }

    if(!expHpText.test(hp.value)){
        alert('휴대폰 번호 형식을 확인하세요 \n하이픈(-)을 포함해야합니다')
        hp.focus(); // pw 쪽으로 포커스
        return false;
    }

    if(!expEmailText.test(email.value)){
        alert('이메일 형식을 확인하세요');
        email.focus();
        return false;
    }
    
    let count = 0;
    for(let i in hobby){
        if(hobby[i].checked){
            count++;
        }
    }
    if(count == 0){
        alert('취미는 적어도 한개 이상 선택하세요');
        return false;
    }

    return true;
}