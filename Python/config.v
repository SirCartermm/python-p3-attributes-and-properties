 const cards = [
    {
        photo: Model2HQ,
        description: 'A',
        label: 'FREE',
        url: 'TEST'
    },
    {
        photo: Model3HQ,
        description: 'B',
        label: 'FREE',
        url: 'TEST'
    },
    {
        photo: Model4HQ,
        description: 'C',
        label: 'FREE',
        url: 'TEST'
    },
    {
        photo: Model1HQ,
        description: 'D',
       label: 'FREE',
        url: 'TEST'
    },
];


const [currentCardIndex, setCurrentCardIndex] = useState(0);
const [cardsPerPage, setCardsPerPage] = useState(5);
const goToNextCard = () => {
    setCurrentCardIndex((prevIndex) => (prevIndex + 1) % cards.length);
};

const goToPreviousCard = () => {
    setCurrentCardIndex((prevIndex) =>
        prevIndex > 0 ? (prevIndex - 1) % cards.length : cards.length - 1
    );
};
const visibleCards = [];
for (let i = 0; i < cardsPerPage; i++) {
    visibleCards.push(cards[(currentCardIndex + i) % cards.length]);
}

useEffect(() => {
    const handleResize = () => {
        const screenWidth = window.innerWidth;

        if (screenWidth >= 1480) {
            setCardsPerPage(5); // Wide
        } else if (screenWidth >= 1024) {
            setCardsPerPage(4); // Desktop
        } else if (screenWidth >= 768) {
            setCardsPerPage(3); // Tablet
        } else {
            setCardsPerPage(2); // Phone
        }
    };

    handleResize(); // Call it once to set initial value
    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
}, []);
and this is where i render them:

<div className="flex mb-[60px] w-full flex justify-between transition-transform">
            {visibleCards.map((card, index) => (
                <div
                    key={index}
                    className={`relative overflow-visible w-[252px] h-[270px] px-[32px] pb-[32px] bg-white bg-opacity-5 border-[1px] border-opacity-10 border-white rounded-3xl backdrop-blur-[14px] flex-col gap-[106px] inline-flex duration-500 transform translate-x-12 tablet:translate-x-0 
                        ${index === cardsPerPage - 1 ? '-ml-[350px] tablet:-ml-52' : ''}`}
                >
                    <Image width={190} height={142} src={card.photo} alt={`Photo ${index + 1}`}
                           className="h-40 w-40 mb-2 absolute -top-16 -right-6"/>

                    <p className="text-xl mt-[105px] text-white font-morabba absolute w-[165px]">
                        <a href={card.url}>
                            {card.description}
                        </a>
                    </p>

                    <div className="flex gap-2 text-white justify-end items-center absolute bottom-8 left-8">
                        <p>{card.label}</p>
                        <label><HiOutlineTag/></label>
                    </div>
                </div>
            ))}
        </div>

