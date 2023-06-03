package study.postvote.dto.voteResult.response;

public class UserSelection {
    private long user_id;
    private String name;
    private long option_id;
    private String label;

    public UserSelection(long user_id, String name, long option_id, String label) {
        this.user_id = user_id;
        this.name = name;
        this.option_id = option_id;
        this.label = label;
    }

    public long getUser_id() {
        return user_id;
    }

    public String getName() {
        return name;
    }

    public long getOption_id() {
        return option_id;
    }

    public String getLabel() {
        return label;
    }
}
