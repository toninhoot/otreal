#include "pch.hpp"

#include <boost/ut.hpp>

#include "utils/wildcardtree.hpp"

using namespace boost::ut;

suite<"utils"> wildcardTreeTest = [] {
        "insert and remove empty string"_test = [] {
                WildcardTreeNode root{false};
                std::string result;

                root.insert("");
                expect(eq(RETURNVALUE_NOERROR, root.findOne("", result)));
                expect(eq(std::string{}, result));

                root.remove("");
                expect(eq(RETURNVALUE_NOERROR, root.findOne("", result)));
        };
};

