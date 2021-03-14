
class test_virtual {
    public:
        virtual int add(int number1,int number2) {
            return number1 + number2;
        }
};

class test_class : public test_virtual {
    public:
        test_class() {
            v1 = 1;
            v2 = 2;
            v3 = 3;
        }

        test_class(int v1,int v2) :
            v1(v1),v2(v2) {

        }

        virtual int add(int number1,int number2) {
            return number1 + number2;
        }
    private:
        int v1;
        int v2;
        int v3;
};

int main(void) {
    test_class test_instance;

    static_cast<test_virtual>(test_instance).add(10,20);

    return 0;
}
