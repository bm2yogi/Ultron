using NUnit.Framework;
using Sahara;
using Ultron.Controllers;

namespace Tests.Unit.HomePage
{
    [TestFixture]
    public class VisitingTheHomePage
    {
        [Test]
        public void It_should_return_a_view()
        {
            new HomeController()
                .Index()
                .ShouldNotBeNull();
        }
        
    }
}