package statemonad;


public class StateTuple <S,C>{
    private S state;
    private C content;

    public StateTuple(S state, C content) {
        this.state = state;
        this.content = content;
    }


    public C getContent() {
        return content;
    }

    public void setContent(C content) {
        this.content = content;
    }

    public S getState() {
        return state;
    }

    public void setState(S state) {
        this.state = state;
    }

    @Override
    public String toString() {
        return "Lable:" +state+ " Data:" + content;
    }
}
